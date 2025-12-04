#!/usr/bin/env python3
"""
VerilogEval Environment Checker - 环境检查脚本

检查当前环境是否具备运行VerilogEval评估的所有条件。

检查项目：
- Python依赖包
- 数据集文件
- 编译工具（iverilog, vvp）
- Ollama服务（如果使用Ollama模型）
- API密钥（如果使用API模型）
- 模型可用性

用法：
    python environment_checker.py                    # 完整环境检查
    python environment_checker.py --basic            # 基础检查
    python environment_checker.py --api              # API配置检查
    python environment_checker.py --ollama           # Ollama检查

SPDX-FileCopyrightText: Copyright (c) 2024
SPDX-License-Identifier: MIT
"""

import sys
import os
import subprocess
import importlib
import glob
from typing import List, Dict, Tuple

# Check required packages
REQUIRED_PACKAGES = [
    'tqdm',
    'requests',  # For API models
]

# Optional packages for API models
OPTIONAL_PACKAGES = [
    'openai',      # For DeepSeek API
]

# Required dataset files
REQUIRED_DATASET_FILES = [
    "dataset_code-complete-iccad2023",
]

# Required tools
REQUIRED_TOOLS = ['iverilog', 'vvp']

class EnvironmentChecker:
    def __init__(self):
        self.errors = []
        self.warnings = []
        self.success_count = 0
        self.total_checks = 0

    def check(self, description: str, condition: bool, error_msg: str = None, warning_msg: str = None):
        """Perform a single check and record result"""
        self.total_checks += 1
        if condition:
            print(f"[✓] {description}")
            self.success_count += 1
        elif warning_msg:
            print(f"[⚠] {description}")
            self.warnings.append(warning_msg)
        else:
            print(f"[✗] {description}")
            if error_msg:
                self.errors.append(error_msg)

    def check_python_packages(self, basic_only: bool = False):
        """Check Python package dependencies"""
        print(f"\n{'='*60}")
        print("PYTHON PACKAGE CHECK")
        print(f"{'='*60}")

        # Check required packages
        for package in REQUIRED_PACKAGES:
            try:
                if basic_only and package in ['requests']:
                    continue
                importlib.import_module(package)
                self.check(f"Package '{package}' installed", True)
            except ImportError:
                self.check(f"Package '{package}' installed", False,
                          error_msg=f"Missing required package: {package}")

        # Check optional packages
        if not basic_only:
            for package in OPTIONAL_PACKAGES:
                try:
                    importlib.import_module(package)
                    self.check(f"Optional package '{package}' installed", True)
                except ImportError:
                    self.check(f"Optional package '{package}' installed", False,
                              warning_msg=f"Missing optional package: {package}")

    def check_dataset(self):
        """Check dataset files"""
        print(f"\n{'='*60}")
        print("DATASET CHECK")
        print(f"{'='*60}")

        # Check main dataset directory
        dataset_exists = os.path.exists("dataset_code-complete-iccad2023")
        self.check("Dataset directory exists", dataset_exists,
                  error_msg="dataset_code-complete-iccad2023 directory not found")

        if dataset_exists:
            # Check for prompt files
            prompt_files = glob.glob("dataset_code-complete-iccad2023/*_prompt.txt")
            prompt_count = len(prompt_files)
            self.check(f"Found {prompt_count} prompt files", prompt_count > 0,
                      error_msg="No prompt files found in dataset")

            # Check for interface files
            ifc_files = glob.glob("dataset_code-complete-iccad2023/*_ifc.txt")
            ifc_count = len(ifc_files)
            self.check(f"Found {ifc_count} interface files", ifc_count > 0,
                      error_msg="No interface files found in dataset")

            # Check for test files
            test_files = glob.glob("dataset_code-complete-iccad2023/*_test.sv")
            test_count = len(test_files)
            self.check(f"Found {test_count} test files", test_count > 0,
                      error_msg="No test files found in dataset")

            # Check for reference files
            ref_files = glob.glob("dataset_code-complete-iccad2023/*_ref.sv")
            ref_count = len(ref_files)
            self.check(f"Found {ref_count} reference files", ref_count > 0,
                      error_msg="No reference files found in dataset")

            # Check file count consistency
            if prompt_count > 0:
                if ifc_count == prompt_count and test_count == prompt_count and ref_count == prompt_count:
                    self.check("File count consistency", True)
                else:
                    self.check("File count consistency", False,
                              error_msg=f"Inconsistent file counts: prompt({prompt_count}), ifc({ifc_count}), test({test_count}), ref({ref_count})")

    def check_tools(self):
        """Check required tools"""
        print(f"\n{'='*60}")
        print("TOOLS CHECK")
        print(f"{'='*60}")

        for tool in REQUIRED_TOOLS:
            try:
                result = subprocess.run([tool, '--version'], capture_output=True, text=True, timeout=5)
                if result.returncode == 0:
                    version = result.stdout.split('\n')[0] if result.stdout else "Available"
                    self.check(f"Tool '{tool}' available", True)
                    print(f"    Version: {version}")
                else:
                    self.check(f"Tool '{tool}' available", False,
                              error_msg=f"Tool {tool} failed to run")
            except FileNotFoundError:
                self.check(f"Tool '{tool}' available", False,
                          error_msg=f"Tool {tool} not found in PATH")
            except subprocess.TimeoutExpired:
                self.check(f"Tool '{tool}' available", False,
                              error_msg=f"Tool {tool} timed out")
            except Exception as e:
                self.check(f"Tool '{tool}' available", False,
                              error_msg=f"Error checking {tool}: {str(e)}")

    def check_ollama(self):
        """Check Ollama service and models"""
        print(f"\n{'='*60}")
        print("OLLAMA CHECK")
        print(f"{'='*60}")

        try:
            # Check if Ollama is running
            result = subprocess.run(['ollama', 'list'], capture_output=True, text=True, timeout=10)
            if result.returncode == 0:
                self.check("Ollama service running", True)

                # Parse available models
                lines = result.stdout.strip().split('\n')
                models = []
                for line in lines[1:]:  # Skip header
                    if line.strip():
                        parts = line.split()
                        if parts:
                            models.append(parts[0])

                if models:
                    self.check(f"Found {len(models)} Ollama models", True)
                    print("  Available models:")
                    for model in models[:10]:  # Show first 10
                        print(f"    - {model}")
                    if len(models) > 10:
                        print(f"    ... and {len(models) - 10} more")
                else:
                    self.check("Ollama models available", False,
                              warning_msg="No Ollama models found")
            else:
                self.check("Ollama service running", False,
                          error_msg="Ollama service not responding")
        except FileNotFoundError:
            self.check("Ollama installed", False,
                      error_msg="Ollama not found in PATH")
        except subprocess.TimeoutExpired:
            self.check("Ollama service responding", False,
                      error_msg="Ollama service timeout")
        except Exception as e:
            self.check("Ollama service check", False,
                      error_msg=f"Error checking Ollama: {str(e)}")

    def check_api_config(self):
        """Check API configuration"""
        print(f"\n{'='*60}")
        print("API CONFIGURATION CHECK")
        print(f"{'='*60}")

        # Check for API keys file
        api_keys_file = "api_keys.json"
        if os.path.exists(api_keys_file):
            self.check("API keys file exists", True)

            try:
                import json
                with open(api_keys_file, 'r') as f:
                    keys = json.load(f)

                print("  Configured APIs:")
                for api_type, config in keys.items():
                    key_length = len(config.get('key', ''))
                    masked_key = f"{'*' * (key_length - 4)}{config['key'][-4:]}" if key_length > 4 else "****"
                    print(f"    - {api_type}: {masked_key}")

                # Check for DeepSeek and GLM
                if 'deepseek' in keys:
                    self.check("DeepSeek API key configured", True)
                else:
                    self.check("DeepSeek API key configured", False,
                              warning_msg="DeepSeek API key not configured")

                if 'zhipuai' in keys:
                    self.check("GLM API key configured", True)
                else:
                    self.check("GLM API key configured", False,
                              warning_msg="GLM API key not configured")

            except Exception as e:
                self.check("API keys file readable", False,
                          error_msg=f"Error reading API keys: {str(e)}")
        else:
            self.check("API keys file exists", False,
                      warning_msg="API keys file not found")

        # Test API connectivity if model_interface is available
        try:
            from model_interface import get_available_models
            models = get_available_models()
            api_models = [m for m in models if m.get('type') == 'api']

            if api_models:
                self.check(f"Found {len(api_models)} API models configured", True)
                for model in api_models:
                    status = "Available" if model.get('available') else "Not Available"
                    print(f"    - {model['name']}: {status}")
            else:
                self.check("API models configured", False,
                          warning_msg="No API models found")
        except ImportError:
            self.check("Model interface available", False,
                      warning_msg="model_interface.py not available")
        except Exception as e:
            self.check("API model check", False,
                      warning_msg=f"Error checking API models: {str(e)}")

    def check_static_analyzer(self):
        """Check static analyzer"""
        print(f"\n{'='*60}")
        print("STATIC ANALYZER CHECK")
        print(f"{'='*60}")

        try:
            from static_analyzer import will_hang_simulation
            self.check("Static analyzer module available", True)

            # Test static analyzer with simple code
            test_code = """
module TopModule(
    output a
);
    assign a = 1'b0;
endmodule
"""
            try:
                will_hang, reason = will_hang_simulation(test_code)
                self.check("Static analyzer functional", True)
            except Exception as e:
                self.check("Static analyzer functional", False,
                          error_msg=f"Static analyzer test failed: {str(e)}")
        except ImportError:
            self.check("Static analyzer module available", False,
                      error_msg="static_analyzer.py not found")

    def check_results_directory(self):
        """Check results directory structure"""
        print(f"\n{'='*60}")
        print("RESULTS DIRECTORY CHECK")
        print(f"{'='*60}")

        if os.path.exists("results"):
            self.check("Results directory exists", True)

            # Check for existing model results
            model_dirs = [d for d in glob.glob("results/*_0shot_temp0.0") if os.path.isdir(d)]
            if model_dirs:
                self.check(f"Found {len(model_dirs)} model result directories", True)
                print("  Existing results:")
                for model_dir in model_dirs[:5]:  # Show first 5
                    model_name = os.path.basename(model_dir).replace('_0shot_temp0.0', '')
                    print(f"    - {model_name}")
                if len(model_dirs) > 5:
                    print(f"    ... and {len(model_dirs) - 5} more")
            else:
                self.check("Existing model results", False,
                          warning_msg="No model results found")
        else:
            self.check("Results directory exists", False,
                      warning_msg="Results directory not found (will be created)")

    def print_summary(self):
        """Print overall summary"""
        print(f"\n{'='*60}")
        print("ENVIRONMENT CHECK SUMMARY")
        print(f"{'='*60}")

        success_rate = (self.success_count / self.total_checks * 100) if self.total_checks > 0 else 0
        print(f"Checks passed: {self.success_count}/{self.total_checks} ({success_rate:.1f}%)")

        if self.errors:
            print(f"\n🔴 ERRORS ({len(self.errors)}):")
            for i, error in enumerate(self.errors, 1):
                print(f"  {i}. {error}")

        if self.warnings:
            print(f"\n🟡 WARNINGS ({len(self.warnings)}):")
            for i, warning in enumerate(self.warnings, 1):
                print(f"  {i}. {warning}")

        if success_rate >= 90:
            print(f"\n✅ Environment is READY for VerilogEval!")
        elif success_rate >= 70:
            print(f"\n⚠️  Environment is MOSTLY ready (some features may be limited)")
        else:
            print(f"\n❌ Environment needs SETUP before running VerilogEval")

        print(f"\nRecommendations:")
        if self.errors:
            print("  - Fix all errors before running evaluation")
        if self.warnings:
            print("  - Consider addressing warnings for full functionality")

def main():
    parser = argparse.ArgumentParser(
        description="Check VerilogEval environment setup",
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        '--basic',
        action='store_true',
        help='Run basic checks only (skip optional components)'
    )
    parser.add_argument(
        '--api',
        action='store_true',
        help='Focus on API configuration checks'
    )
    parser.add_argument(
        '--ollama',
        action='store_true',
        help='Focus on Ollama checks'
    )

    args = parser.parse_args()

    print("VerilogEval Environment Checker")
    print("=" * 60)

    checker = EnvironmentChecker()

    # Always run basic checks
    checker.check_python_packages(basic_only=True)
    checker.check_dataset()
    checker.check_tools()
    checker.check_static_analyzer()
    checker.check_results_directory()

    # Run additional checks based on arguments
    if not args.basic:
        if args.api:
            checker.check_api_config()
        elif args.ollama:
            checker.check_ollama()
        else:
            # Run all additional checks
            checker.check_python_packages(basic_only=False)
            checker.check_ollama()
            checker.check_api_config()

    checker.print_summary()

    # Exit with error code if there are errors
    if checker.errors:
        sys.exit(1)
    else:
        sys.exit(0)

if __name__ == "__main__":
    main()