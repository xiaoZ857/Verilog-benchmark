#!/usr/bin/env python3
"""
VerilogEval Results Analyzer - 结果汇总分析脚本

收集已有模型的全部结果，进行排名、比较和分析。

功能：
- 扫描results目录中的所有模型结果
- 运行编译测试器获取准确分数
- 生成排名、比较和详细分析
- 输出CSV和HTML报告

用法：
    python results_analyzer.py                         # 分析所有模型
    python results_analyzer.py --model deepseek_v3_2   # 分析指定模型
    python results_analyzer.py --force                 # 强制重新测试
    python results_analyzer.py --report html           # 生成HTML报告

SPDX-FileCopyrightText: Copyright (c) 2024
SPDX-License-Identifier: MIT
"""

import sys
import os
import json
import glob
import argparse
import subprocess
import time
from typing import List, Dict, Optional, Tuple
from dataclasses import dataclass, asdict
from pathlib import Path
import pandas as pd

try:
    from tqdm import tqdm
except ImportError:
    print("ERROR: tqdm package not installed")
    print("Install with: pip install tqdm")
    sys.exit(1)

# ============================================================================
# Data Classes
# ============================================================================

@dataclass
class ModelResult:
    """Results for a single model"""
    model_name: str
    total_problems: int
    generated: int
    compiled: int
    passed: int
    failed_compilation: List[str]
    failed_test: List[str]
    skipped_static_analysis: List[str]
    compile_rate: float
    pass_rate: float
    generation_rate: float

@dataclass
class AnalysisSummary:
    """Summary of all models analysis"""
    total_models: int
    total_problems: int
    models: List[ModelResult]
    best_pass_rate: Optional[str]
    best_compile_rate: Optional[str]
    analysis_time: float

# ============================================================================
# Utility Functions
# ============================================================================

def find_model_directories() -> List[str]:
    """Find all model result directories in results/"""
    results_dir = Path("results")
    if not results_dir.exists():
        print("Error: results/ directory not found")
        return []

    # Find directories that follow the naming pattern
    model_dirs = []
    for item in results_dir.iterdir():
        if item.is_dir() and item.name.endswith("_0shot_temp0.0"):
            # Check if this directory contains model results
            sample01_files = list(item.glob("*/*_sample01.sv"))
            if sample01_files:
                model_dirs.append(str(item))

    return sorted(model_dirs)

def extract_model_name(directory: str) -> str:
    """Extract clean model name from directory path"""
    dir_name = os.path.basename(directory)
    # Remove timestamp suffix
    if dir_name.endswith("_0shot_temp0.0"):
        return dir_name.replace("_0shot_temp0.0", "")
    return dir_name

def get_problem_list() -> List[str]:
    """Get list of all problems from dataset directory"""
    if not os.path.exists("dataset_code-complete-iccad2023"):
        print("Warning: dataset directory not found, using file counting")
        return []

    prompt_files = sorted(Path("dataset_code-complete-iccad2023").glob("*_prompt.txt"))
    problems = []
    for file in prompt_files:
        basename = os.path.basename(file)
        problem_name = basename[:-11]  # Remove _prompt.txt suffix
        problems.append(problem_name)

    return problems

def run_compile_test(model_dir: str) -> Optional[ModelResult]:
    """Run compile test runner on a specific model directory"""
    try:
        # Import the compile test runner
        sys.path.append('.')
        from compile_test_runner import test_model

        print(f"Testing {extract_model_name(model_dir)}...")
        result = test_model(model_dir)
        return result

    except Exception as e:
        print(f"Error testing {model_dir}: {str(e)}")
        return None

def load_existing_results(model_dir: str) -> Optional[ModelResult]:
    """Load existing results from compile_test_results.json if available"""
    compile_test_dir = os.path.join(model_dir, "compile_test_result")
    results_file = os.path.join(compile_test_dir, "compile_test_results.json")

    if os.path.exists(results_file):
        try:
            with open(results_file, 'r') as f:
                data = json.load(f)

            # Count generated problems
            total_problems = data.get('total_problems', 0)
            generated = data.get('generated', 0)
            compiled = data.get('compiled', 0)
            passed = data.get('passed', 0)

            # Calculate rates
            compile_rate = (compiled / total_problems * 100) if total_problems > 0 else 0.0
            pass_rate = (passed / total_problems * 100) if total_problems > 0 else 0.0
            generation_rate = (generated / total_problems * 100) if total_problems > 0 else 0.0

            return ModelResult(
                model_name=data.get('model_name', extract_model_name(model_dir)),
                total_problems=total_problems,
                generated=generated,
                compiled=compiled,
                passed=passed,
                failed_compilation=data.get('failed_compilation', []),
                failed_test=data.get('failed_test', []),
                skipped_static_analysis=data.get('skipped_static_analysis', []),
                compile_rate=compile_rate,
                pass_rate=pass_rate,
                generation_rate=generation_rate
            )

        except Exception as e:
            print(f"Error loading results for {model_dir}: {str(e)}")
            return None

    return None

def estimate_generation_rate(model_dir: str, total_problems: int) -> float:
    """Estimate generation rate by counting existing output files"""
    if total_problems == 0:
        return 0.0

    # Count problems with generated files
    generated_count = 0
    model_path = Path(model_dir)

    for problem_dir in model_path.iterdir():
        if problem_dir.is_dir():
            # Look for sample01.sv or similar files
            sv_files = list(problem_dir.glob("*_sample01.sv"))
            if sv_files:
                generated_count += 1

    return (generated_count / total_problems * 100) if total_problems > 0 else 0.0

# ============================================================================
# Analysis Functions
# ============================================================================

def analyze_models(model_dirs: List[str], force_retest: bool = False) -> List[ModelResult]:
    """Analyze all models"""
    results = []
    total_problems = len(get_problem_list())

    print(f"\nAnalyzing {len(model_dirs)} models...")
    print("=" * 60)

    for model_dir in tqdm(model_dirs, desc="Analyzing models"):
        model_name = extract_model_name(model_dir)

        # Try to load existing results first
        result = None
        if not force_retest:
            result = load_existing_results(model_dir)

        # If no existing results or force retest, run the test
        if result is None or force_retest:
            result = run_compile_test(model_dir)

        if result:
            # Ensure generation rate is set
            if result.generation_rate == 0 and total_problems > 0:
                result.generation_rate = estimate_generation_rate(model_dir, total_problems)
            results.append(result)
        else:
            # Create a basic result even if testing failed
            generation_rate = estimate_generation_rate(model_dir, total_problems)
            results.append(ModelResult(
                model_name=model_name,
                total_problems=total_problems,
                generated=int(generation_rate * total_problems / 100),
                compiled=0,
                passed=0,
                failed_compilation=[],
                failed_test=[],
                skipped_static_analysis=[],
                compile_rate=0.0,
                pass_rate=0.0,
                generation_rate=generation_rate
            ))

    return results

def generate_comparison_report(results: List[ModelResult]) -> AnalysisSummary:
    """Generate comprehensive comparison report"""
    if not results:
        return AnalysisSummary(0, 0, [], None, None, 0.0)

    # Sort by pass rate
    results_sorted = sorted(results, key=lambda x: x.pass_rate, reverse=True)

    # Find best performers
    best_pass_rate = results_sorted[0].model_name if results_sorted else None
    best_compile_rate = sorted(results, key=lambda x: x.compile_rate, reverse=True)[0].model_name if results else None

    return AnalysisSummary(
        total_models=len(results),
        total_problems=results[0].total_problems if results else 0,
        models=results_sorted,
        best_pass_rate=best_pass_rate,
        best_compile_rate=best_compile_rate,
        analysis_time=0.0  # Would be set by caller
    )

def print_summary_report(summary: AnalysisSummary):
    """Print summary report to console"""
    print(f"\n{'='*80}")
    print("VERILOGEVAL RESULTS ANALYSIS SUMMARY")
    print(f"{'='*80}")

    print(f"\nTotal Models Analyzed: {summary.total_models}")
    print(f"Total Problems: {summary.total_problems}")

    if summary.models:
        print(f"\n{'Model':<25} {'Generated':<10} {'Compiled':<10} {'Passed':<10} {'Gen%':<7} {'Comp%':<7} {'Pass%':<7}")
        print(f"{'-'*85}")

        for result in summary.models:
            print(f"{result.model_name:<25} "
                  f"{result.generated:<10} "
                  f"{result.compiled:<10} "
                  f"{result.passed:<10} "
                  f"{result.generation_rate:<7.1f} "
                  f"{result.compile_rate:<7.1f} "
                  f"{result.pass_rate:<7.1f}")

        print(f"\n{'='*80}")
        print("RANKINGS")
        print(f"{'='*80}")

        # Pass rate ranking
        print(f"\nPass Rate Ranking (Top 10):")
        for i, result in enumerate(summary.models[:10], 1):
            print(f"  {i:2d}. {result.model_name:<25} {result.pass_rate:>6.1f}% ({result.passed:3d}/{result.total_problems})")

        # Compile rate ranking
        compile_sorted = sorted(summary.models, key=lambda x: x.compile_rate, reverse=True)
        print(f"\nCompile Rate Ranking (Top 10):")
        for i, result in enumerate(compile_sorted[:10], 1):
            print(f"  {i:2d}. {result.model_name:<25} {result.compile_rate:>6.1f}% ({result.compiled:3d}/{result.total_problems})")

        # Statistics
        avg_pass_rate = sum(r.pass_rate for r in summary.models) / len(summary.models)
        avg_compile_rate = sum(r.compile_rate for r in summary.models) / len(summary.models)
        avg_generation_rate = sum(r.generation_rate for r in summary.models) / len(summary.models)

        print(f"\nAverages:")
        print(f"  Generation Rate: {avg_generation_rate:.1f}%")
        print(f"  Compile Rate:    {avg_compile_rate:.1f}%")
        print(f"  Pass Rate:       {avg_pass_rate:.1f}%")

        # Best performers
        if summary.best_pass_rate:
            best_model = next(r for r in summary.models if r.model_name == summary.best_pass_rate)
            print(f"\nBest Performer (Pass Rate): {summary.best_pass_rate}")
            print(f"  Pass Rate: {best_model.pass_rate:.1f}% ({best_model.passed}/{best_model.total_problems})")
            print(f"  Compile Rate: {best_model.compile_rate:.1f}%")

        if summary.best_compile_rate:
            best_model = next(r for r in summary.models if r.model_name == summary.best_compile_rate)
            print(f"\nBest Performer (Compile Rate): {summary.best_compile_rate}")
            print(f"  Compile Rate: {best_model.compile_rate:.1f}% ({best_model.compiled}/{best_model.total_problems})")
            print(f"  Pass Rate: {best_model.pass_rate:.1f}%")

def save_csv_report(results: List[ModelResult], filename: str):
    """Save results to CSV file"""
    data = []
    for result in results:
        data.append({
            'model': result.model_name,
            'total_problems': result.total_problems,
            'generated': result.generated,
            'compiled': result.compiled,
            'passed': result.passed,
            'generation_rate': result.generation_rate,
            'compile_rate': result.compile_rate,
            'pass_rate': result.pass_rate,
            'failed_compilation': len(result.failed_compilation),
            'failed_test': len(result.failed_test),
            'skipped_static_analysis': len(result.skipped_static_analysis)
        })

    df = pd.DataFrame(data)
    df.to_csv(filename, index=False)
    print(f"CSV report saved to: {filename}")

def save_detailed_json_report(results: List[ModelResult], filename: str):
    """Save detailed results to JSON file"""
    data = {
        'summary': {
            'total_models': len(results),
            'total_problems': results[0].total_problems if results else 0
        },
        'models': [asdict(result) for result in results]
    }

    with open(filename, 'w') as f:
        json.dump(data, f, indent=2)
    print(f"Detailed JSON report saved to: {filename}")

def generate_html_report(results: List[ModelResult], filename: str):
    """Generate HTML report"""
    html_content = f"""
<!DOCTYPE html>
<html>
<head>
    <title>VerilogEval Results Analysis</title>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; }}
        table {{ border-collapse: collapse; width: 100%; margin: 20px 0; }}
        th, td {{ border: 1px solid #ddd; padding: 8px; text-align: left; }}
        th {{ background-color: #f2f2f2; }}
        .pass-rate {{ background-color: #d4edda; }}
        .compile-rate {{ background-color: #cce5ff; }}
        .generation-rate {{ background-color: #fff3cd; }}
    </style>
</head>
<body>
    <h1>VerilogEval Results Analysis</h1>

    <h2>Summary</h2>
    <p>Total Models: {len(results)}</p>
    <p>Total Problems: {results[0].total_problems if results else 0}</p>

    <h2>Model Rankings</h2>
    <table>
        <tr>
            <th>Rank</th>
            <th>Model</th>
            <th>Generated</th>
            <th>Compiled</th>
            <th>Passed</th>
            <th class="generation-rate">Gen Rate %</th>
            <th class="compile-rate">Compile Rate %</th>
            <th class="pass-rate">Pass Rate %</th>
        </tr>
"""

    for i, result in enumerate(sorted(results, key=lambda x: x.pass_rate, reverse=True), 1):
        html_content += f"""
        <tr>
            <td>{i}</td>
            <td>{result.model_name}</td>
            <td>{result.generated}</td>
            <td>{result.compiled}</td>
            <td>{result.passed}</td>
            <td class="generation-rate">{result.generation_rate:.1f}</td>
            <td class="compile-rate">{result.compile_rate:.1f}</td>
            <td class="pass-rate">{result.pass_rate:.1f}</td>
        </tr>
"""

    html_content += """
    </table>

    <p>Generated by VerilogEval Results Analyzer</p>
</body>
</html>
"""

    with open(filename, 'w') as f:
        f.write(html_content)
    print(f"HTML report saved to: {filename}")

# ============================================================================
# Main Function
# ============================================================================

def main():
    parser = argparse.ArgumentParser(
        description="Analyze VerilogEval results",
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        '--model',
        type=str,
        help='Analyze specific model only'
    )
    parser.add_argument(
        '--force',
        action='store_true',
        help='Force retest all models (ignore existing results)'
    )
    parser.add_argument(
        '--report',
        choices=['csv', 'json', 'html', 'all'],
        default='console',
        help='Generate report format'
    )
    parser.add_argument(
        '--output',
        type=str,
        default='results_analysis',
        help='Output file prefix for reports'
    )

    args = parser.parse_args()

    print("VerilogEval Results Analyzer")
    print("=" * 50)

    start_time = time.time()

    # Find model directories
    if args.model:
        # Test specific model
        model_dir = f"results/{args.model}_0shot_temp0.0"
        if not os.path.exists(model_dir):
            print(f"Error: Model directory not found: {model_dir}")
            sys.exit(1)
        model_dirs = [model_dir]
    else:
        # Find all model directories
        model_dirs = find_model_directories()
        if not model_dirs:
            print("No model result directories found")
            sys.exit(1)

    print(f"Found {len(model_dirs)} model(s) to analyze")

    # Analyze models
    results = analyze_models(model_dirs, force_retest=args.force)

    if not results:
        print("No results to analyze")
        sys.exit(1)

    # Generate summary
    summary = generate_comparison_report(results)
    summary.analysis_time = time.time() - start_time

    # Print console report
    if args.report in ['console', 'all']:
        print_summary_report(summary)

    # Generate additional reports
    if args.report in ['csv', 'all']:
        save_csv_report(results, f"{args.output}.csv")

    if args.report in ['json', 'all']:
        save_detailed_json_report(results, f"{args.output}.json")

    if args.report in ['html', 'all']:
        generate_html_report(results, f"{args.output}.html")

    print(f"\nAnalysis completed in {summary.analysis_time:.2f} seconds")

if __name__ == "__main__":
    main()