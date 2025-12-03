#!/usr/bin/env python3
"""
Comprehensive VerilogEval Test Suite

This script provides a unified interface for all VerilogEval testing functionality:
- Environment checking
- Model availability testing
- Single model testing
- Full model suite testing
- Results analysis

Usage:
    python test_suite.py check
    python test_suite.py models
    python test_suite.py test --model phi4:14b --limit 10
    python test_suite.py test-all
    python test_suite.py analyze

SPDX-FileCopyrightText: Copyright (c) 2024
SPDX-License-Identifier: MIT
"""

import sys
import os
import subprocess
import argparse
from typing import List, Optional

def run_script(script_name: str, args: List[str]) -> bool:
    """Run a Python script and return success status"""
    try:
        cmd = ['python', script_name] + args
        result = subprocess.run(cmd, capture_output=True, text=True)

        if result.stdout:
            print(result.stdout)
        if result.stderr:
            print(result.stderr, file=sys.stderr)

        return result.returncode == 0
    except Exception as e:
        print(f"Error running {script_name}: {e}", file=sys.stderr)
        return False

def check_environment():
    """Check if the testing environment is properly set up"""
    print("=" * 60)
    print("CHECKING VERILOGEVAL ENVIRONMENT")
    print("=" * 60)

    return run_script('check_prerequisites.py', [])

def check_models():
    """Check model availability"""
    print("=" * 60)
    print("CHECKING MODEL AVAILABILITY")
    print("=" * 60)

    return run_script('check_models.py', [])

def run_single_test(model: str, limit: Optional[int] = None, start: Optional[int] = None):
    """Run test for a single model"""
    print("=" * 60)
    print(f"RUNNING SINGLE MODEL TEST: {model}")
    print("=" * 60)

    args = ['--model', model]
    if limit is not None:
        args.extend(['--limit', str(limit)])
    if start is not None:
        args.extend(['--start', str(start)])

    return run_script('run_verilog_eval.py', args)

def run_all_tests():
    """Run tests for all models"""
    print("=" * 60)
    print("RUNNING ALL MODEL TESTS")
    print("=" * 60)

    return run_script('run_all_models.py', [])

def analyze_results():
    """Analyze test results"""
    print("=" * 60)
    print("ANALYZING TEST RESULTS")
    print("=" * 60)

    return run_script('analyze_results.py', [])

def show_status():
    """Show current test status"""
    print("=" * 60)
    print("VERILOGEVAL TEST STATUS")
    print("=" * 60)

    # Check if results directory exists
    results_dir = "results"
    if os.path.exists(results_dir):
        model_dirs = [d for d in os.listdir(results_dir) if d.endswith('_0shot_temp0.0')]
        print(f"Results found for {len(model_dirs)} models:")
        for model_dir in sorted(model_dirs):
            model_display = model_dir.replace('_0shot_temp0.0', '').replace('_', ':')
            print(f"  - {model_display}")
    else:
        print("No results directory found")
        print("Run 'python test_suite.py test-all' to generate results")

    # Check for analysis reports
    if os.path.exists("analysis_report.txt"):
        print("\nAnalysis reports available:")
        print("  - analysis_report.txt")
        print("  - analysis_report.csv")
        print("  - analysis_report.json")
    else:
        print("\nNo analysis reports found")
        print("Run 'python test_suite.py analyze' to generate reports")

def main():
    parser = argparse.ArgumentParser(
        description="Comprehensive VerilogEval Test Suite",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python test_suite.py check              # Check environment
  python test_suite.py models             # Check model availability
  python test_suite.py test --model phi4:14b --limit 10  # Test specific model
  python test_suite.py test-all           # Test all models
  python test_suite.py analyze            # Analyze results
  python test_suite.py status             # Show current status
        """
    )

    subparsers = parser.add_subparsers(dest='command', help='Available commands')

    # Check command
    subparsers.add_parser('check', help='Check testing environment')

    # Models command
    subparsers.add_parser('models', help='Check model availability')

    # Test command
    test_parser = subparsers.add_parser('test', help='Run tests')
    test_parser.add_argument('--model', required=True, help='Model to test')
    test_parser.add_argument('--limit', type=int, help='Limit number of problems')
    test_parser.add_argument('--start', type=int, default=0, help='Start from problem N')

    # Test-all command
    subparsers.add_parser('test-all', help='Run tests for all models')

    # Analyze command
    analyze_parser = subparsers.add_parser('analyze', help='Analyze results')
    analyze_parser.add_argument('--results-dir', default='results', help='Results directory')
    analyze_parser.add_argument('--output', default='analysis', help='Output prefix')

    # Status command
    subparsers.add_parser('status', help='Show current status')

    args = parser.parse_args()

    if not args.command:
        parser.print_help()
        return

    success = True

    if args.command == 'check':
        success = check_environment()
    elif args.command == 'models':
        success = check_models()
    elif args.command == 'test':
        success = run_single_test(args.model, args.limit, args.start)
    elif args.command == 'test-all':
        success = run_all_tests()
    elif args.command == 'analyze':
        analyze_args = []
        if args.results_dir != 'results':
            analyze_args.extend(['--results-dir', args.results_dir])
        if args.output != 'analysis':
            analyze_args.extend(['--output', args.output])
        success = run_script('analyze_results.py', analyze_args)
    elif args.command == 'status':
        show_status()

    if not success:
        sys.exit(1)
    else:
        print("\nOK Command completed successfully")

if __name__ == "__main__":
    main()