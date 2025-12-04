#!/usr/bin/env python3
"""
VerilogEval Results Retesting Script

This script reads all generated model results from the results/ directory
and re-evaluates compilation and test pass rates using the correct logic.

Usage:
    python retest_all_models.py

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

# Import static analyzer
from static_analyzer import will_hang_simulation

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

def find_result_directories() -> List[str]:
    """Find all model result directories in results/ - supports unified format"""
    results_dir = Path("results")
    if not results_dir.exists():
        print("Error: results/ directory not found")
        return []

    # Find all directories with result patterns
    model_dirs = []
    for item in results_dir.iterdir():
        if item.is_dir() and item.name.endswith("_0shot_temp0.0"):
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
    # Remove timestamp suffix if present
    if "_0shot_temp0.0" in dir_name:
        return dir_name.replace("_0shot_temp0.0", "")
    return dir_name

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
        with open(code_file, 'r') as f:
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
                with open(log_file, 'w') as f:
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
                    with open(log_file, 'w') as f:
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
                with open(log_file, 'w') as f:
                    f.write(f"Problem: {problem_name}\n")
                    f.write(f"Code file: {complete_file}\n")
                    f.write("Compilation: FAILED\n")
                    f.write("="*50 + "\n")
                    f.write(log_content)

        except Exception as e:
            failed_compilation.append(problem_name)
            error_log = os.path.join(test_dir, f"{problem_name}_error.log")
            with open(error_log, 'w') as f:
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
    with open(results_file, 'w') as f:
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
        }, f, indent=2)

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
    with open(csv_file, 'w') as f:
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
  python compile_test_runner.py                    # Test all models
  python compile_test_runner.py --model deepseek_v3_2  # Test specific model
  python compile_test_runner.py --list           # List available models
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

    args = parser.parse_args()

    print("VerilogEval Compile Test Runner - Safe Mode with Static Analysis")
    print("="*70)
    print("Re-evaluating model results with correct compilation and testing logic")
    print("Including static analysis for infinite loop detection\n")

    # Find all model result directories
    all_model_dirs = find_result_directories()

    if not all_model_dirs:
        print("No model result directories found in results/")
        return

    # Filter for specific model if requested
    if args.model:
        # Find the specific model directory
        target_dir = None
        for model_dir in all_model_dirs:
            model_name = extract_model_name(model_dir)
            if model_name == args.model:
                target_dir = model_dir
                break

        if not target_dir:
            # Try to construct the directory name
            potential_dir = f"results/{args.model}_0shot_temp0.0"
            if os.path.exists(potential_dir):
                target_dir = potential_dir
            else:
                print(f"Error: Model '{args.model}' not found")
                print(f"Available models:")
                for model_dir in all_model_dirs:
                    print(f"  - {extract_model_name(model_dir)}")
                return

        model_dirs = [target_dir]
        print(f"Testing specific model: {args.model}")
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