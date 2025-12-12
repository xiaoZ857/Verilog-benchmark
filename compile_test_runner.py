#!/usr/bin/env python3
"""
VerilogEval Results Retesting Script

This script reads all generated model results from the results/ directory
and re-evaluates compilation and test pass rates using the correct logic.

Usage:
    python compile_test_runner.py                                    # Test all models
    python compile_test_runner.py --model deepseek_v3_2              # Test specific model
    python compile_test_runner.py --prompt-strategy v1               # Test only v1 strategy results
    python compile_test_runner.py --temperature 0.8 --top-p 0.95     # Filter by parameters

SPDX-FileCopyrightText: Copyright (c) 2024
SPDX-License-Identifier: MIT
"""

import os
import sys
import json
import subprocess
import re
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass
from pathlib import Path
from tqdm import tqdm

# Static Analysis Functions
def will_hang_simulation(verilog_code: str) -> Tuple[bool, Optional[str]]:
    """
    Check for patterns that cause simulation to hang.
    Detects combinational loops and other problematic patterns.

    Enhanced to detect:
    - Direct combinational loops: assign sig = ... sig ...
    - Loops with bit selection: assign sig[n:m] = ... sig ...
    - Loops with unary operators: assign sig = ... ~sig ...
    - Complex feedback loops through assign and always blocks
    """
    lines = [line.strip() for line in verilog_code.split('\n') if line.strip()]

    # Pattern 1: Direct combinational loop in assign statement
    # Original pattern: assign signal = ... signal ...
    for line in lines:
        if line.startswith('assign '):
            # Look for pattern where a signal depends on itself in the same assign statement
            match = re.match(r'assign\s+(\w+)\s*=.*\b\1\b', line)
            if match:
                signal = match.group(1)
                return True, f"Direct combinational loop: {signal} depends on itself in assign statement"

    # Pattern 2: Combinational loop with bit selection on left side
    # Example: assign q[3:0] = ( ~reset & clk ) ? {15'b1111} : ( ~q + 1'b1 );
    # The signal 'q' appears on both sides
    for line in lines:
        if line.startswith('assign '):
            # Match: assign signal[...] = expression  OR  assign signal = expression
            match = re.match(r'assign\s+(\w+)(?:\s*\[.*?\])?\s*=(.+)', line)
            if match:
                signal = match.group(1)
                expression = match.group(2)
                # Check if the same signal appears in the expression (with word boundary)
                # This catches cases like: ~q, q+1, q[0], etc.
                if re.search(rf'\b{re.escape(signal)}\b', expression):
                    return True, f"Combinational loop: {signal} depends on itself (found in expression)"

    # Pattern 3: Complex feedback loops through assign and always blocks
    # Specifically: assign A = B; and always block uses A to set B
    assign_signals = {}
    for line in lines:
        if line.startswith('assign '):
            match = re.match(r'assign\s+(\w+)(?:\s*\[.*?\])?\s*=\s*([^;]+)', line)
            if match:
                signal = match.group(1)
                expression = match.group(2)
                assign_signals[signal] = expression

    # Look for patterns like: assign prev_state = state; and always blocks using prev_state to update state
    for signal, expression in assign_signals.items():
        if '=' in expression:  # Simple assignment
            dep = expression.split('=')[0].strip()
            # Check if there are always blocks that use the assigned signal to update the dependency
            for line in lines:
                if 'always' in line and '<=' in line and signal in line and dep in line:
                    return True, f"Complex feedback loop: {signal} and {dep} create circular dependency"

    # Pattern 4: Output declared as reg but assigned with continuous assignment (common error)
    # This often leads to simulation issues
    reg_outputs = set()
    for line in lines:
        # Find output reg declarations
        if re.match(r'output\s+reg\s+', line) or re.match(r'output\s+\[.*?\]\s*reg\s+', line):
            # Extract signal name
            match = re.search(r'(\w+)\s*[,;)\]]?\s*$', line)
            if match:
                reg_outputs.add(match.group(1))

    # Check if any reg output is used in assign statement (potential issue)
    for line in lines:
        if line.startswith('assign '):
            for reg_sig in reg_outputs:
                if re.match(rf'assign\s+{re.escape(reg_sig)}\b', line):
                    return True, f"Invalid assignment: {reg_sig} is declared as reg but used in continuous assignment"

    return False, None

@dataclass
class ModelResult:
    """Result for a single model"""
    model_name: str
    total_problems: int
    generated: int
    compiled: int
    passed: int
    failed_compilation: List[str]
    failed_test: List[str]
    skipped_static_analysis: List[str]  # Files that would hang simulation
    compile_rate: float
    pass_rate: float

def find_result_directories(temperature: Optional[float] = None, top_p: Optional[float] = None,
                            prompt_strategy: Optional[str] = None) -> List[str]:
    """Find all model result directories in results/ - supports unified format with optional filtering

    Args:
        temperature: Filter by temperature (optional)
        top_p: Filter by top_p (optional)
        prompt_strategy: Filter by prompt strategy (optional). Use "default" for no-suffix dirs.

    Returns:
        List of matching directory paths
    """
    results_dir = Path("results")
    if not results_dir.exists():
        print("Error: results/ directory not found")
        return []

    # Find all directories with result patterns
    model_dirs = []
    for item in results_dir.iterdir():
        if item.is_dir() and ("_0shot_temp" in item.name):
            # Parse temperature, top_p, and prompt_strategy from directory name
            dir_name = item.name

            # Extract temperature, top_p, and optional prompt strategy from directory name
            # Pattern: {model}_0shot_temp{temp}_topP{top_p}[_prompt{strategy}]
            match = re.search(r'_0shot_temp(.+?)_topP(.+?)(?:_prompt(.+))?$', dir_name)
            if match:
                dir_temp_str = match.group(1).replace('_', '.')
                dir_top_p_str = match.group(2).replace('_', '.')
                dir_prompt_strategy = match.group(3) if match.group(3) else "default"

                try:
                    dir_temp = float(dir_temp_str)
                    dir_top_p = float(dir_top_p_str)

                    # Apply filters if specified
                    if temperature is not None and abs(dir_temp - temperature) > 0.001:
                        continue
                    if top_p is not None and abs(dir_top_p - top_p) > 0.001:
                        continue
                    if prompt_strategy is not None and dir_prompt_strategy != prompt_strategy:
                        continue
                except ValueError:
                    # If parsing fails, include the directory
                    pass

            # Check if this directory contains model results using unified format
            # Unified format: problem directories with sample01.sv files
            sample01_files = list(item.glob("*/*_sample01.sv"))
            # Fallback patterns for compatibility
            complete_files = list(item.glob("*_complete.sv"))  # Old API format
            alt_files = list(item.glob("*_sample01.sv"))      # Alternative Ollama format

            if sample01_files or complete_files or alt_files:
                model_dirs.append(str(item))

    return sorted(model_dirs)

def extract_model_name(directory: str) -> str:
    """Extract clean model name from directory path"""
    dir_name = os.path.basename(directory)
    # Match pattern like "_0shot_tempX_X_topPY_Y[_promptZ]" and remove it
    # Supports both old format and new format with prompt strategy suffix
    match = re.search(r'(.+?)_0shot_temp.*$', dir_name)
    if match:
        return match.group(1)
    return dir_name


def extract_prompt_strategy(directory: str) -> str:
    """Extract prompt strategy from directory path"""
    dir_name = os.path.basename(directory)
    # Match pattern like "_prompt{strategy}" at the end
    match = re.search(r'_prompt([^_]+)$', dir_name)
    if match:
        return match.group(1)
    return "default"

def get_problem_list() -> List[str]:
    """Get list of all problems from dataset directory"""
    if not os.path.exists("dataset_code-complete-iccad2023"):
        print("Error: dataset_code-complete-iccad2023 directory not found")
        return []

    prompt_files = sorted(Path("dataset_code-complete-iccad2023").glob("*_prompt.txt"))
    problems = []
    for file in prompt_files:
        basename = os.path.basename(file)
        problem_name = basename[:-11]  # Remove _prompt.txt suffix
        problems.append(problem_name)

    return problems

# ============================================================================
# Standalone Compile/Test Functions (for iterative fix mode)
# ============================================================================

def compile_verilog_only(code_file: str, problem_name: str, output_dir: str) -> Tuple[bool, str, Optional[str]]:
    """
    Compile Verilog code only (without running tests).

    Args:
        code_file: Path to the Verilog code file
        problem_name: Name of the problem
        output_dir: Directory to store compiled binary

    Returns:
        (success, log_content, bin_file_path)
        - success: True if compilation succeeded
        - log_content: Compilation log/error messages
        - bin_file_path: Path to compiled binary (None if failed)
    """
    dataset_dir = os.path.abspath("dataset_code-complete-iccad2023")
    test_file = f"{dataset_dir}/{problem_name}_test.sv"
    ref_file = f"{dataset_dir}/{problem_name}_ref.sv"
    sample_name = os.path.basename(code_file).replace('.sv', '')
    bin_file = os.path.join(output_dir, sample_name)

    log_lines = []

    # Check if required files exist
    if not os.path.exists(test_file):
        return False, f"Test file not found: {test_file}", None
    if not os.path.exists(ref_file):
        return False, f"Reference file not found: {ref_file}", None

    # Static analysis for potential infinite loops
    log_lines.append("=== Static Analysis ===")
    try:
        with open(code_file, 'r', encoding='utf-8') as f:
            code_content = f.read()
        will_hang, reason = will_hang_simulation(code_content)
        if will_hang:
            log_lines.append("SKIP: Simulation-hanging pattern detected")
            log_lines.append(f"Reason: {reason}")
            return False, '\n'.join(log_lines), None
        else:
            log_lines.append("PASS: No simulation-hanging patterns detected")
    except Exception as e:
        log_lines.append(f"WARNING: Static analysis failed: {e}")
        log_lines.append("Proceeding with compilation...")
    log_lines.append("=" * 50)

    # Compile
    try:
        os.makedirs(output_dir, exist_ok=True)
        compile_cmd = [
            'iverilog',
            '-Wall',
            '-Winfloop',
            '-Wno-timescale',
            '-g2012',
            '-s', 'tb',
            '-o', bin_file,
            code_file,
            test_file,
            ref_file
        ]

        result = subprocess.run(
            compile_cmd,
            capture_output=True,
            text=True,
            timeout=5
        )

        log_lines.append("=== Compilation ===")
        log_lines.append(f"Return code: {result.returncode}")
        if result.stdout:
            log_lines.append(result.stdout)
        if result.stderr:
            log_lines.append(result.stderr)

        if result.returncode != 0:
            return False, '\n'.join(log_lines), None

        return True, '\n'.join(log_lines), bin_file

    except subprocess.TimeoutExpired:
        log_lines.append("Compilation timeout")
        return False, '\n'.join(log_lines), None
    except Exception as e:
        log_lines.append(f"Compilation error: {str(e)}")
        return False, '\n'.join(log_lines), None


def run_test_only(bin_file: str) -> Tuple[bool, str, int]:
    """
    Run test on compiled Verilog binary.

    Args:
        bin_file: Path to compiled binary (from iverilog)

    Returns:
        (success, log_content, mismatch_count)
        - success: True if test passed (0 mismatches)
        - log_content: Test output log
        - mismatch_count: Number of mismatches (-1 if could not parse)
    """
    log_lines = []

    if not os.path.exists(bin_file):
        return False, f"Binary file not found: {bin_file}", -1

    try:
        test_cmd = ['vvp', bin_file]
        result = subprocess.run(
            test_cmd,
            capture_output=True,
            text=True,
            timeout=5
        )

        log_lines.append("=== Test Execution ===")
        log_lines.append(f"Return code: {result.returncode}")
        if result.stdout:
            log_lines.append(result.stdout)
        if result.stderr:
            log_lines.append(result.stderr)

        # Parse mismatch count
        mismatch_pattern = r'Mismatches: (\d+) in \d+ samples'
        match = re.search(mismatch_pattern, result.stdout)

        if match:
            mismatch_count = int(match.group(1))
            test_success = (result.returncode == 0 and mismatch_count == 0)
        else:
            # Fallback for other output formats
            if "Mismatches: 0" in result.stdout:
                mismatch_count = 0
                test_success = (result.returncode == 0)
            else:
                mismatch_count = -1
                test_success = False

        return test_success, '\n'.join(log_lines), mismatch_count

    except subprocess.TimeoutExpired:
        log_lines.append("Test timeout - possible infinite loop detected")
        return False, '\n'.join(log_lines), -1
    except Exception as e:
        log_lines.append(f"Test execution error: {str(e)}")
        return False, '\n'.join(log_lines), -1
    finally:
        # Clean up binary file
        try:
            if os.path.exists(bin_file):
                os.remove(bin_file)
        except:
            pass


def compile_and_test_single(code_file: str, problem_name: str, output_dir: str) -> Tuple[bool, bool, str, str, int]:
    """
    Compile and test a single Verilog file (convenience function).

    Args:
        code_file: Path to the Verilog code file
        problem_name: Name of the problem
        output_dir: Directory to store compiled binary

    Returns:
        (compile_success, test_success, compile_log, test_log, mismatch_count)
    """
    compile_success, compile_log, bin_file = compile_verilog_only(code_file, problem_name, output_dir)

    if not compile_success:
        return False, False, compile_log, "", -1

    test_success, test_log, mismatch_count = run_test_only(bin_file)
    return compile_success, test_success, compile_log, test_log, mismatch_count


# ============================================================================
# File Discovery Functions
# ============================================================================

def find_complete_file(model_dir: str, problem_name: str) -> Optional[str]:
    """Find the complete Verilog file for a problem - supports unified format"""
    # Unified format for all models (API + Ollama)
    patterns = [
        # Both API and Ollama models now use this format
        f"{problem_name}/{problem_name}_sample01.sv",
        f"{problem_name}/{problem_name}_sample01",      # Without .sv extension
        # Fallback patterns for older results
        f"{problem_name}_complete.sv",                 # Old API format
        f"{problem_name}_sample01.sv",                 # Alternative Ollama format
        f"{problem_name}_sample01",                    # Alternative without extension
        # Check for just the problem name as file
        f"{problem_name}.sv"
    ]

    for pattern in patterns:
        file_path = os.path.join(model_dir, pattern)
        if os.path.exists(file_path):
            return file_path

    return None

def compile_and_test_code(code_file: str, problem_name: str, test_dir: str) -> Tuple[bool, bool, str]:
    """
    Compile and test Verilog code with static analysis safety checks

    Returns:
        (compilation_success, test_success, log_content)
    """
    # Use absolute paths
    dataset_dir = os.path.abspath("dataset_code-complete-iccad2023")
    test_file = f"{dataset_dir}/{problem_name}_test.sv"
    ref_file = f"{dataset_dir}/{problem_name}_ref.sv"
    sample_name = os.path.basename(code_file).replace('.sv', '')
    bin_file = os.path.join(test_dir, sample_name)

    log_lines = []

    # Check if required files exist
    if not os.path.exists(test_file):
        return False, False, f"Test file not found: {test_file}"
    if not os.path.exists(ref_file):
        return False, False, f"Reference file not found: {ref_file}"

    # Static analysis for potential infinite loops
    log_lines.append("=== Static Analysis ===")
    try:
        # Read the code content for static analysis
        with open(code_file, 'r', encoding='utf-8') as f:
            code_content = f.read()
        will_hang, reason = will_hang_simulation(code_content)
        if will_hang:
            log_lines.append("SKIP: Simulation-hanging pattern detected")
            log_lines.append(f"Reason: {reason}")
            return False, False, '\n'.join(log_lines)
        else:
            log_lines.append("PASS: No simulation-hanging patterns detected")
    except Exception as e:
        log_lines.append(f"WARNING: Static analysis failed: {e}")
        log_lines.append("Proceeding with compilation...")
    log_lines.append("=" * 50)

    # Compile
    try:
        compile_cmd = [
            'iverilog',
            '-Wall',
            '-Winfloop',
            '-Wno-timescale',
            '-g2012',
            '-s', 'tb',
            '-o', bin_file,
            code_file,
            test_file,
            ref_file
        ]

        result = subprocess.run(
            compile_cmd,
            capture_output=True,
            text=True,
            timeout=5
        )

        if result.returncode != 0:
            log_lines.append(f"Compilation failed (exit code {result.returncode}):")
            log_lines.append(result.stdout)
            log_lines.append(result.stderr)
            return False, False, '\n'.join(log_lines)

    except subprocess.TimeoutExpired:
        return False, False, "Compilation timeout"
    except Exception as e:
        return False, False, f"Compilation error: {str(e)}"

    # Run test with longer timeout for safety
    try:
        # Use vvp for all platforms (iverilog generates VVP scripts)
        test_cmd = ['vvp', bin_file]
        result = subprocess.run(
            test_cmd,
            capture_output=True,
            text=True,
            timeout=5  # Reduced timeout for faster testing
        )

        log_lines.append(f"Test exit code: {result.returncode}")
        log_lines.append(result.stdout)
        if result.stderr:
            log_lines.append(result.stderr)

        # Check if test passed - use the same logic as original sv-iv-analyze script
        import re
        mismatch_pattern = r'Mismatches: (\d+) in \d+ samples'
        match = re.search(mismatch_pattern, result.stdout)

        if match:
            num_mismatch = int(match.group(1))
            test_success = (result.returncode == 0 and num_mismatch == 0)
        else:
            # Fallback for other output formats
            test_success = (result.returncode == 0 and
                           "Mismatches: 0" in result.stdout)

        return True, test_success, '\n'.join(log_lines)

    except subprocess.TimeoutExpired:
        log_lines.append("Test timeout - possible infinite loop detected")
        return True, False, "Test timeout"
    except Exception as e:
        log_lines.append(f"Test execution error: {str(e)}")
        return True, False, f"Test error: {str(e)}"

    finally:
        # Clean up binary file
        try:
            if os.path.exists(bin_file):
                os.remove(bin_file)
        except:
            pass

def test_model(model_dir: str) -> ModelResult:
    """Test all problems for a model"""
    model_name = extract_model_name(model_dir)
    problems = get_problem_list()
    if not problems:
        return ModelResult(model_name, 0, 0, 0, 0, [], [], [], 0.0, 0.0)

    total_problems = len(problems)
    generated = 0
    compiled = 0
    passed = 0
    failed_compilation = []
    failed_test = []
    skipped_static_analysis = []

    # Create test directory for this model
    test_dir = os.path.join(model_dir, "compile_test_result")
    os.makedirs(test_dir, exist_ok=True)

    # Test each problem with progress bar
    for problem_name in tqdm(problems, desc=f"Testing {model_name}", leave=True):
        complete_file = find_complete_file(model_dir, problem_name)

        if not complete_file:
            # No generated file found
            continue

        generated += 1

        try:
            compilation_success, test_success, log_content = compile_and_test_code(
                complete_file, problem_name, test_dir
            )

            # Check if static analysis flagged this as dangerous
            if "SKIP: Simulation-hanging pattern detected" in log_content:
                skipped_static_analysis.append(problem_name)
                # Save log for skipped files
                log_file = os.path.join(test_dir, f"{problem_name}_skipped.log")
                with open(log_file, 'w', encoding='utf-8') as f:
                    f.write(f"Problem: {problem_name}\n")
                    f.write(f"Code file: {complete_file}\n")
                    f.write("Status: SKIPPED (static analysis)\n")
                    f.write("="*50 + "\n")
                    f.write(log_content)
                continue

            if compilation_success:
                compiled += 1
                if test_success:
                    passed += 1
                else:
                    failed_test.append(problem_name)

                    # Save detailed log for failed tests
                    log_file = os.path.join(test_dir, f"{problem_name}_failed.log")
                    with open(log_file, 'w', encoding='utf-8') as f:
                        f.write(f"Problem: {problem_name}\n")
                        f.write(f"Code file: {complete_file}\n")
                        f.write("Compilation: SUCCESS\n")
                        f.write("Test: FAILED\n")
                        f.write("="*50 + "\n")
                        f.write(log_content)
            else:
                failed_compilation.append(problem_name)

                # Save detailed log for compilation failures
                log_file = os.path.join(test_dir, f"{problem_name}_compile_failed.log")
                with open(log_file, 'w', encoding='utf-8') as f:
                    f.write(f"Problem: {problem_name}\n")
                    f.write(f"Code file: {complete_file}\n")
                    f.write("Compilation: FAILED\n")
                    f.write("="*50 + "\n")
                    f.write(log_content)

        except Exception as e:
            failed_compilation.append(problem_name)
            error_log = os.path.join(test_dir, f"{problem_name}_error.log")
            with open(error_log, 'w', encoding='utf-8') as f:
                f.write(f"Error testing {problem_name}: {str(e)}")

    compile_rate = (compiled / total_problems * 100) if total_problems > 0 else 0.0
    pass_rate = (passed / total_problems * 100) if total_problems > 0 else 0.0

    result = ModelResult(
        model_name=model_name,
        total_problems=total_problems,
        generated=generated,
        compiled=compiled,
        passed=passed,
        failed_compilation=failed_compilation,
        failed_test=failed_test,
        skipped_static_analysis=skipped_static_analysis,
        compile_rate=compile_rate,
        pass_rate=pass_rate
    )

    # Save detailed results
    results_file = os.path.join(test_dir, "compile_test_results.json")
    with open(results_file, 'w', encoding='utf-8') as f:
        json.dump({
            'model_name': model_name,
            'total_problems': total_problems,
            'generated': generated,
            'compiled': compiled,
            'passed': passed,
            'failed_compilation': failed_compilation,
            'failed_test': failed_test,
            'skipped_static_analysis': skipped_static_analysis,
            'compile_rate': compile_rate,
            'pass_rate': pass_rate
        }, f, indent=2, ensure_ascii=False)

    # Print immediate results for this model
    print(f"\n{model_name}: {compiled}/{total_problems} compiled ({compile_rate:.1f}%) | {passed}/{total_problems} passed ({pass_rate:.1f}%)")

    return result

def generate_comparison_report(results: List[ModelResult]):
    """Generate comparison report for all models"""
    print(f"\n{'='*80}")
    print(f"VERILOGEVAL RETEST RESULTS SUMMARY")
    print(f"{'='*80}")

    # Sort by pass rate
    results.sort(key=lambda x: x.pass_rate, reverse=True)

    print(f"\n{'Model':<20} {'Generated':<10} {'Compiled':<10} {'Passed':<10} {'Compile%':<10} {'Pass%':<10}")
    print(f"{'-'*80}")

    for result in results:
        print(f"{result.model_name:<20} {result.generated:<10} {result.compiled:<10} "
              f"{result.passed:<10} {result.compile_rate:<10.1f} {result.pass_rate:<10.1f}")

    print(f"\n{'='*80}")
    print(f"DETAILED STATISTICS")
    print(f"{'='*80}")

    for result in results:
        print(f"\n{result.model_name}:")
        print(f"  Total problems: {result.total_problems}")
        print(f"  Successfully generated: {result.generated} ({result.generated/result.total_problems*100:.1f}%)")
        print(f"  Successfully compiled: {result.compiled} ({result.compile_rate:.1f}%)")
        print(f"  Passed tests: {result.passed} ({result.pass_rate:.1f}%)")
        print(f"  Failed compilation: {len(result.failed_compilation)} problems")
        print(f"  Failed tests: {len(result.failed_test)} problems")

    # Save CSV report
    csv_file = "results/compile_test_summary.csv"
    with open(csv_file, 'w', encoding='utf-8') as f:
        f.write("model,total_problems,generated,compiled,passed,compile_rate,pass_rate\n")
        for result in results:
            f.write(f"{result.model_name},{result.total_problems},{result.generated},"
                   f"{result.compiled},{result.passed},{result.compile_rate:.2f},"
                   f"{result.pass_rate:.2f}\n")

    print(f"\nDetailed logs saved in each model's 'compile_test_result' directory")
    print(f"Summary CSV saved to: {csv_file}")

def main():
    import argparse

    parser = argparse.ArgumentParser(
        description="Compile and test VerilogEval models",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python compile_test_runner.py                           # Test all models
  python compile_test_runner.py --model deepseek_v3_2     # Test specific model
  python compile_test_runner.py --list                    # List available models
  python compile_test_runner.py --temperature 0.8         # Test all models with temp=0.8
  python compile_test_runner.py --temperature 0.8 --top-p 0.95  # Test with specific params
  python compile_test_runner.py --prompt-strategy v1      # Test only v1 strategy results
  python compile_test_runner.py --model llama3_2_3b --prompt-strategy v1  # Test specific model with v1
        """
    )
    parser.add_argument(
        '--model',
        type=str,
        help='Test specific model only (use model name without _0shot_temp0.0 suffix)'
    )
    parser.add_argument(
        '--list',
        action='store_true',
        help='List all available models'
    )
    parser.add_argument(
        '--temperature',
        type=float,
        help='Filter models by generation temperature (e.g., 0.8)'
    )
    parser.add_argument(
        '--top-p',
        type=float,
        dest='top_p',
        help='Filter models by generation top_p (e.g., 0.95)'
    )
    parser.add_argument(
        '--prompt-strategy',
        type=str,
        dest='prompt_strategy',
        help='Filter models by prompt strategy (e.g., default, v1)'
    )

    args = parser.parse_args()

    print("VerilogEval Compile Test Runner - Safe Mode with Static Analysis")
    print("="*70)
    print("Re-evaluating model results with correct compilation and testing logic")
    print("Including static analysis for infinite loop detection")

    # Show filtering criteria if applied
    if args.temperature is not None or args.top_p is not None or args.prompt_strategy is not None:
        filter_criteria = []
        if args.temperature is not None:
            filter_criteria.append(f"temperature={args.temperature}")
        if args.top_p is not None:
            filter_criteria.append(f"top_p={args.top_p}")
        if args.prompt_strategy is not None:
            filter_criteria.append(f"prompt_strategy={args.prompt_strategy}")
        print(f"\nFiltering models by: {', '.join(filter_criteria)}")

    print()

    # Find model result directories with optional filtering
    all_model_dirs = find_result_directories(args.temperature, args.top_p, args.prompt_strategy)

    if not all_model_dirs:
        print("No model result directories found in results/")
        return

    # Filter for specific model if requested
    if args.model:
        # Find the specific model directory (considering temperature/top_p filters)
        target_dir = None
        for model_dir in all_model_dirs:
            model_name = extract_model_name(model_dir)
            if model_name == args.model:
                target_dir = model_dir
                break

        if not target_dir:
            print(f"Error: Model '{args.model}' not found")
            if args.temperature is not None or args.top_p is not None or args.prompt_strategy is not None:
                filter_info = []
                if args.temperature is not None:
                    filter_info.append(f"temperature={args.temperature}")
                if args.top_p is not None:
                    filter_info.append(f"top_p={args.top_p}")
                if args.prompt_strategy is not None:
                    filter_info.append(f"prompt_strategy={args.prompt_strategy}")
                print(f"with the specified filters: {', '.join(filter_info)}")
            print(f"Available models:")
            for model_dir in all_model_dirs:
                model_name = extract_model_name(model_dir)
                prompt_strat = extract_prompt_strategy(model_dir)
                print(f"  - {model_name} (prompt: {prompt_strat})")
            return

        model_dirs = [target_dir]
        print(f"Testing specific model: {args.model}")
        if args.temperature is not None or args.top_p is not None or args.prompt_strategy is not None:
            filter_info = []
            if args.temperature is not None:
                filter_info.append(f"temp={args.temperature}")
            if args.top_p is not None:
                filter_info.append(f"top_p={args.top_p}")
            if args.prompt_strategy is not None:
                filter_info.append(f"prompt={args.prompt_strategy}")
            print(f"with parameters: {', '.join(filter_info)}")
    else:
        model_dirs = all_model_dirs

    if args.list:
        print("Available models:")
        for model_dir in all_model_dirs:
            model_name = extract_model_name(model_dir)
            print(f"  - {model_name}")
        return

    print(f"Found {len(model_dirs)} models to test:")
    for dir_name in model_dirs:
        print(f"  - {extract_model_name(dir_name)}")
    print()

    # Test each model with progress bar and immediate results
    results = []
    for model_dir in model_dirs:
        try:
            result = test_model(model_dir)
            results.append(result)
        except Exception as e:
            model_name = extract_model_name(model_dir)
            print(f"\n{model_name}: ERROR - {str(e)}")
            continue

    # Final summary report
    if results:
        print(f"\n{'='*70}")
        print("FINAL SUMMARY")
        print(f"{'='*70}")

        # Sort by pass rate
        results.sort(key=lambda x: x.pass_rate, reverse=True)

        print(f"\n{'Model':<20} {'Generated':<10} {'Compiled':<15} {'Passed':<15}")
        print(f"{'-'*70}")

        for result in results:
            print(f"{result.model_name:<20} "
                  f"{result.generated:<10} "
                  f"{result.compiled}/{result.total_problems} ({result.compile_rate:<5.1f}%)  "
                  f"{result.passed}/{result.total_problems} ({result.pass_rate:<5.1f}%)  ")

        print(f"\n{'='*70}")
        print("Detailed logs saved in each model's 'compile_test_result' directory")
        print("CSV summary saved to: results/compile_test_summary.csv")

        # Check for any skipped files due to static analysis
        total_skipped = sum(len(r.skipped_static_analysis) for r in results)
        if total_skipped > 0:
            print(f"\n[WARNING] Static Analysis: {total_skipped} files skipped due to infinite loop risk")
    else:
        print("No models were successfully tested")

if __name__ == "__main__":
    main()