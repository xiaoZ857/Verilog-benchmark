#!/usr/bin/env python3
"""
Comprehensive Results Analyzer for VerilogEval

This script analyzes test results from multiple models and generates:
- Summary reports
- CSV data for analysis
- Failure analysis
- Performance comparisons

Usage:
    python analyze_results.py
    python analyze_results.py --results-dir results
    python analyze_results.py --model phi4_14b_0shot_temp0.0

SPDX-FileCopyrightText: Copyright (c) 2024
SPDX-License-Identifier: MIT
"""

import sys
import os
import json
import csv
import re
from typing import Dict, List, Optional
from dataclasses import dataclass
from pathlib import Path
import glob

@dataclass
class ModelResults:
    """Results for a single model"""
    model_name: str
    total_problems: int
    compiled: int
    passed: int
    compile_rate: float
    pass_rate: float
    failed_compilation: int
    compiled_but_failed: int

def find_result_files(results_dir: str = "results") -> List[str]:
    """Find all result JSON files"""
    pattern = os.path.join(results_dir, "*_results.json")
    return glob.glob(pattern)

def load_results_from_json(json_file: str) -> Dict:
    """Load results from JSON file"""
    try:
        with open(json_file, 'r') as f:
            return json.load(f)
    except Exception as e:
        print(f"Error loading {json_file}: {e}")
        return {}

def load_results_from_model_dir(model_dir: str) -> Optional[ModelResults]:
    """Load results from a specific model directory"""
    # Try to find results.json
    results_file = os.path.join(model_dir, "results.json")
    if not os.path.exists(results_file):
        # Fallback: manually count results
        return count_results_from_directory(model_dir)

    try:
        with open(results_file, 'r') as f:
            data = json.load(f)

        total = data.get('total_problems', 0)
        results = data.get('results', [])

        passed = sum(1 for r in results if r.get('test_success', False))
        compiled = sum(1 for r in results if r.get('compilation_success', False))

        compile_rate = (compiled / total * 100) if total > 0 else 0.0
        pass_rate = (passed / total * 100) if total > 0 else 0.0

        model_name = os.path.basename(model_dir)

        return ModelResults(
            model_name=model_name,
            total_problems=total,
            compiled=compiled,
            passed=passed,
            compile_rate=compile_rate,
            pass_rate=pass_rate,
            failed_compilation=total - compiled,
            compiled_but_failed=compiled - passed
        )
    except Exception as e:
        print(f"Error processing {model_dir}: {e}")
        return None

def count_results_from_directory(model_dir: str) -> Optional[ModelResults]:
    """Count results by examining log files"""
    try:
        model_name = os.path.basename(model_dir)

        # Count all problem directories
        problem_dirs = glob.glob(os.path.join(model_dir, "Prob*"))
        total = len(problem_dirs)

        if total == 0:
            return None

        compiled = 0
        passed = 0

        for problem_dir in problem_dirs:
            # Look for retest log files (fixed results)
            retest_logs = glob.glob(os.path.join(problem_dir, "*RETEST.log"))

            if retest_logs:
                # Use the most recent retest log
                log_file = retest_logs[0]
                try:
                    with open(log_file, 'r') as f:
                        content = f.read()

                    if "SKIP: Simulation-hanging pattern detected" in content:
                        continue  # Skip due to static analysis

                    # Check compilation status
                    if "Return code: 0" in content.split("=== Compilation ===")[1].split("=== Test Execution ===")[0]:
                        compiled += 1

                        # Check test success
                        if "Mismatches: 0" in content:
                            passed += 1
                except:
                    continue
            else:
                # Fallback: check original test logs
                test_logs = glob.glob(os.path.join(problem_dir, "*-sv-iv-test.log"))
                if test_logs:
                    log_file = test_logs[0]
                    try:
                        with open(log_file, 'r') as f:
                            content = f.read()

                        if "Return code: 0" in content:
                            compiled += 1
                            if "Mismatches: 0" in content:
                                passed += 1
                    except:
                        continue

        compile_rate = (compiled / total * 100) if total > 0 else 0.0
        pass_rate = (passed / total * 100) if total > 0 else 0.0

        return ModelResults(
            model_name=model_name,
            total_problems=total,
            compiled=compiled,
            passed=passed,
            compile_rate=compile_rate,
            pass_rate=pass_rate,
            failed_compilation=total - compiled,
            compiled_but_failed=compiled - passed
        )
    except Exception as e:
        print(f"Error counting results from {model_dir}: {e}")
        return None

def analyze_all_models(results_dir: str) -> List[ModelResults]:
    """Analyze results from all models"""
    model_dirs = glob.glob(os.path.join(results_dir, "*_0shot_temp0.0"))
    results = []

    for model_dir in model_dirs:
        result = load_results_from_model_dir(model_dir)
        if result:
            results.append(result)

    # Sort by pass rate
    return sorted(results, key=lambda x: x.pass_rate, reverse=True)

def generate_text_report(results: List[ModelResults], output_file: str):
    """Generate a text report"""
    lines = [
        "=" * 80,
        "VerilogEval - Model Performance Analysis",
        "=" * 80,
        "",
        f"{'Model':<25} {'Pass@1':<10} {'Compiled':<10} {'Passed/Total':<15}",
        "-" * 80,
    ]

    for result in results:
        # Clean model name for display
        model_display = result.model_name.replace('_0shot_temp0.0', '').replace('_', ':')
        pass_str = f"{result.pass_rate:.1f}%"
        compile_str = f"{result.compile_rate:.1f}%"
        passed_total_str = f"{result.passed}/{result.total_problems}"

        lines.append(
            f"{model_display:<25} {pass_str:<10} {compile_str:<10} {passed_total_str:<15}"
        )

    lines.extend([
        "",
        "=" * 80,
        "Detailed Statistics",
        "=" * 80,
        "",
    ])

    for result in results:
        model_display = result.model_name.replace('_0shot_temp0.0', '').replace('_', ':')
        lines.append(f"\n{model_display}:")
        lines.append(f"  Total problems: {result.total_problems}")
        lines.append(f"  Successfully compiled: {result.compiled} ({result.compile_rate:.1f}%)")
        lines.append(f"  Passed tests: {result.passed} ({result.pass_rate:.1f}%)")
        lines.append(f"  Failed compilation: {result.failed_compilation}")
        lines.append(f"  Compiled but failed tests: {result.compiled_but_failed}")

    report_text = "\n".join(lines)

    with open(output_file, 'w') as f:
        f.write(report_text)

    return report_text

def generate_csv_report(results: List[ModelResults], output_file: str):
    """Generate CSV report"""
    with open(output_file, 'w', newline='') as f:
        writer = csv.writer(f)

        # Header
        writer.writerow([
            'model', 'total_problems', 'compiled', 'passed',
            'compile_rate', 'pass_rate', 'failed_compilation', 'compiled_but_failed'
        ])

        # Data rows
        for result in results:
            model_display = result.model_name.replace('_0shot_temp0.0', '').replace('_', ':')
            writer.writerow([
                model_display, result.total_problems, result.compiled, result.passed,
                f"{result.compile_rate:.2f}", f"{result.pass_rate:.2f}",
                result.failed_compilation, result.compiled_but_failed
            ])

def generate_json_report(results: List[ModelResults], output_file: str):
    """Generate JSON report"""
    data = []
    for result in results:
        data.append({
            'model_display': result.model_name.replace('_0shot_temp0.0', '').replace('_', ':'),
            'model_name': result.model_name,
            'total_problems': result.total_problems,
            'compiled': result.compiled,
            'passed': result.passed,
            'compile_rate': result.compile_rate,
            'pass_rate': result.pass_rate,
            'failed_compilation': result.failed_compilation,
            'compiled_but_failed': result.compiled_but_failed
        })

    with open(output_file, 'w') as f:
        json.dump(data, f, indent=2)

def main():
    import argparse

    parser = argparse.ArgumentParser(
        description="Analyze VerilogEval test results"
    )
    parser.add_argument(
        '--results-dir',
        type=str,
        default='results',
        help='Results directory (default: results)'
    )
    parser.add_argument(
        '--model',
        type=str,
        default=None,
        help='Analyze specific model only'
    )
    parser.add_argument(
        '--output',
        type=str,
        default='analysis',
        help='Output prefix for reports (default: analysis)'
    )

    args = parser.parse_args()

    if not os.path.exists(args.results_dir):
        print(f"Error: Results directory '{args.results_dir}' not found")
        sys.exit(1)

    if args.model:
        # Analyze specific model
        model_dir = os.path.join(args.results_dir, args.model)
        if not os.path.exists(model_dir):
            print(f"Error: Model directory '{model_dir}' not found")
            sys.exit(1)

        result = load_results_from_model_dir(model_dir)
        if result:
            results = [result]
        else:
            print(f"Error: Could not load results for {args.model}")
            sys.exit(1)
    else:
        # Analyze all models
        results = analyze_all_models(args.results_dir)

    if not results:
        print("No results found to analyze")
        sys.exit(1)

    # Generate reports
    text_file = f"{args.output}_report.txt"
    csv_file = f"{args.output}_report.csv"
    json_file = f"{args.output}_report.json"

    generate_text_report(results, text_file)
    generate_csv_report(results, csv_file)
    generate_json_report(results, json_file)

    # Print summary
    print("=" * 60)
    print("VERILOGEVAL MODEL PERFORMANCE ANALYSIS")
    print("=" * 60)
    print(f"Models analyzed: {len(results)}")
    print(f"Results directory: {args.results_dir}")
    print(f"Reports generated:")
    print(f"  Text report: {text_file}")
    print(f"  CSV report: {csv_file}")
    print(f"  JSON report: {json_file}")
    print()

    # Top performers
    print("TOP PERFORMERS:")
    for i, result in enumerate(results[:3], 1):
        model_display = result.model_name.replace('_0shot_temp0.0', '').replace('_', ':')
        print(f"  {i}. {model_display}: {result.pass_rate:.1f}% pass rate")

if __name__ == "__main__":
    main()