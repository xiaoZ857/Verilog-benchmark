#!/usr/bin/env python3
"""
VerilogEval Model Generator - 统一模型输出脚本

支持Ollama和API模型，生成Verilog代码并保存到results目录。

功能：
- 支持小测试模式（--limit）和全量模式
- 支持分模型测试（--model）
- 调用model_interface.py的抽象接口
- 保存模型原始输出到results目录

用法：
    python model_generator.py --all                    # 生成所有模型
    python model_generator.py --model deepseek-v3.2    # 生成指定API模型
    python model_generator.py --model llama3.2-3b      # 生成指定Ollama模型
    python model_generator.py --limit 10               # 小测试模式（前10个问题）
    python model_generator.py --list                   # 列出所有可用模型

SPDX-FileCopyrightText: Copyright (c) 2024
SPDX-License-Identifier: MIT
"""

import sys
import os
import argparse
import json
import time
import glob
from typing import List, Dict, Optional
from pathlib import Path

# Import model interface
from model_interface import get_available_models, generate_code_for_problem, is_model_available

try:
    from tqdm import tqdm
except ImportError:
    print("ERROR: tqdm package not installed")
    print("Install with: pip install tqdm")
    sys.exit(1)

# ============================================================================
# Configuration
# ============================================================================

DATASET_DIR = "dataset_code-complete-iccad2023"

# Prompt prefix (from sv-generate)
PROMPT_PREFIX = """// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.
"""

# ============================================================================
# Utility Functions
# ============================================================================

def get_problem_list() -> List[str]:
    """Get list of all problems from dataset directory"""
    prompt_files = sorted(glob.glob(f"{DATASET_DIR}/*_prompt.txt"))

    problems = []
    for file in prompt_files:
        basename = os.path.basename(file)
        # Remove _prompt.txt suffix
        problem_name = basename[:-11]
        problems.append(problem_name)

    return problems

def read_file(filepath: str) -> str:
    """Read file contents"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return f.read().strip()
    except UnicodeDecodeError:
        # Fallback to system default encoding if UTF-8 fails
        try:
            with open(filepath, 'r') as f:
                return f.read().strip()
        except Exception as e:
            print(f"Error reading {filepath}: {e}")
            return ""
    except Exception as e:
        print(f"Error reading {filepath}: {e}")
        return ""

def prepare_prompt(problem_name: str) -> tuple:
    """
    Prepare prompt for the problem

    Returns:
        (full_prompt, prompt_content, interface_content)
    """
    prompt_file = f"{DATASET_DIR}/{problem_name}_prompt.txt"
    ifc_file = f"{DATASET_DIR}/{problem_name}_ifc.txt"

    prompt_content = read_file(prompt_file)
    ifc_content = read_file(ifc_file)

    if not prompt_content:
        raise ValueError(f"Could not read prompt file: {prompt_file}")

    if not ifc_content:
        raise ValueError(f"Could not read interface file: {ifc_file}")

    full_prompt = PROMPT_PREFIX + prompt_content

    return full_prompt, prompt_content, ifc_content

def get_model_output_dir(model_name: str, temperature: float = 0.0, top_p: float = 0.01) -> str:
    """Get output directory for a model, using consistent naming"""
    # Convert model name to safe directory name (remove file system unsafe characters)
    model_name_safe = model_name.replace(':', '_').replace('-', '_').replace('.', '_')
    # Format temperature and top_p for folder name
    temp_str = str(temperature).replace('.', '_')
    top_p_str = str(top_p).replace('.', '_')
    return f"results/{model_name_safe}_0shot_temp{temp_str}_topP{top_p_str}"

def generate_single_problem(model_name: str, problem_name: str, temperature: float = 0.0, top_p: float = 0.01) -> bool:
    """
    Generate code for a single problem using model interface

    Returns:
        True if successful, False otherwise
    """
    try:
        # Prepare prompt
        full_prompt, prompt_content, ifc_content = prepare_prompt(problem_name)

        # Use model interface to generate code
        success = generate_code_for_problem(
            model_name=model_name,
            problem_name=problem_name,
            prompt=full_prompt,
            interface=ifc_content,
            temperature=temperature,
            top_p=top_p
        )

        return success

    except Exception as e:
        print(f"Error generating {problem_name} with {model_name}: {e}")
        return False

def generate_for_model(model_name: str, problems: List[str], temperature: float = 0.0, top_p: float = 0.01) -> Dict[str, int]:
    """
    Generate code for all problems with a specific model

    Returns:
        Dictionary with success/failure counts
    """
    print(f"\nGenerating code with {model_name}...")
    print(f"Parameters: temperature={temperature}, top_p={top_p}")
    print("-" * 50)

    # Get output directory
    output_dir = get_model_output_dir(model_name, temperature, top_p)
    os.makedirs(output_dir, exist_ok=True)

    # Check for resume - skip already completed problems
    completed_problems = set()
    for problem in problems:
        problem_dir = os.path.join(output_dir, problem)
        complete_file = f"{problem_dir}/{problem}_sample01.sv"
        if os.path.exists(complete_file):
            completed_problems.add(problem)

    if completed_problems:
        print(f"Found {len(completed_problems)} already completed problems, will skip them")
        remaining_problems = [p for p in problems if p not in completed_problems]
        print(f"Remaining problems to generate: {len(remaining_problems)}")
    else:
        remaining_problems = problems

    if not remaining_problems:
        print("All problems already completed!")
        return {"success": len(problems), "failed": 0, "total": len(problems)}

    # Check if model is available
    if not is_model_available(model_name):
        print(f"Error: Model {model_name} is not available")
        return {"success": 0, "failed": len(problems), "total": len(problems)}

    # Generate code for each problem
    success_count = 0
    error_count = 0

    for problem_name in tqdm(remaining_problems, desc=f"Generating {model_name}"):
        if generate_single_problem(model_name, problem_name, temperature, top_p):
            success_count += 1
        else:
            error_count += 1

        # Small delay to avoid overwhelming the system
        time.sleep(0.1)

    print(f"\nResults for {model_name}:")
    print(f"  Successful: {success_count}")
    print(f"  Failed: {error_count}")
    print(f"  Total: {len(remaining_problems)}")
    print(f"  Output directory: {output_dir}")

    return {
        "success": success_count + len(completed_problems),
        "failed": error_count,
        "total": len(problems)
    }

def main():
    parser = argparse.ArgumentParser(
        description="Generate Verilog code using various models",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python model_generator.py --all                    # Generate for all available models
  python model_generator.py --model deepseek-v3.2   # Generate for specific API model
  python model_generator.py --model llama3.2-3b     # Generate for specific Ollama model
  python model_generator.py --api-models            # Generate for all API models only
  python model_generator.py --ollama-models         # Generate for all Ollama models only
  python model_generator.py --list                   # List all available models
  python model_generator.py --limit 10               # Quick test with first 10 problems
  python model_generator.py --start 50              # Start from problem 50 (resume)
        """
    )

    # Model selection options
    model_group = parser.add_mutually_exclusive_group()
    model_group.add_argument(
        '--all',
        action='store_true',
        help='Generate for all available models'
    )
    model_group.add_argument(
        '--model',
        type=str,
        help='Generate for specific model name'
    )
    model_group.add_argument(
        '--api-models',
        action='store_true',
        help='Generate for all API models only'
    )
    model_group.add_argument(
        '--ollama-models',
        action='store_true',
        help='Generate for all Ollama models only'
    )
    model_group.add_argument(
        '--list',
        action='store_true',
        help='List all available models'
    )

    # Problem selection options
    parser.add_argument(
        '--limit',
        type=int,
        default=None,
        help='Limit number of problems to generate (for quick testing)'
    )
    parser.add_argument(
        '--start',
        type=int,
        default=0,
        help='Start from problem N (0-indexed)'
    )

    # Generation parameters
    parser.add_argument(
        '--temperature',
        type=float,
        default=0.0,
        help='Generation temperature (default: 0.0)'
    )
    parser.add_argument(
        '--top-p',
        type=float,
        default=0.01,
        dest='top_p',
        help='Generation top_p (default: 0.01)'
    )

    args = parser.parse_args()

    # Handle list models
    if args.list:
        available_models = get_available_models()
        print("\nAvailable Models:")
        print("=" * 60)

        api_models = [m for m in available_models if m.type == 'api']
        ollama_models = [m for m in available_models if m.type == 'ollama']

        if api_models:
            print("\nAPI Models:")
            for model in api_models:
                status = "[OK]" if model.available else "[X]"
                print(f"  {model.name:<20} {status}")

        if ollama_models:
            print("\nOllama Models:")
            for model in ollama_models:
                status = "[OK]" if model.available else "[X]"
                print(f"  {model.name:<20} {status}")

        return

    print(f"\nVerilogEval Model Generator")
    print("=" * 50)
    print(f"Dataset: {DATASET_DIR}")
    print(f"Mode: Zero-shot, temp={args.temperature}, top_p={args.top_p}")

    # Get problem list
    problems = get_problem_list()
    total_problems = len(problems)

    if args.start >= total_problems:
        print(f"Error: Start index {args.start} exceeds total problems {total_problems}")
        sys.exit(1)

    # Apply start index and limit
    problems = problems[args.start:]
    if args.limit:
        problems = problems[:args.limit]

    print(f"Problems to generate: {len(problems)} (from {args.start} to {args.start + len(problems) - 1})")

    # Determine which models to use
    models_to_generate = []

    if args.all:
        available_models = get_available_models()
        models_to_generate = [m.name for m in available_models if m.available]
    elif args.api_models:
        available_models = get_available_models()
        models_to_generate = [m.name for m in available_models if m.type == 'api' and m.available]
    elif args.ollama_models:
        available_models = get_available_models()
        models_to_generate = [m.name for m in available_models if m.type == 'ollama' and m.available]
    elif args.model:
        # Try to match the model name with available models (handle name format differences)
        available_models = get_available_models()
        matching_model = None

        # First try exact match
        for model in available_models:
            if model.name == args.model:
                matching_model = model.name
                break

        # If no exact match, try to match with common variations
        if not matching_model:
            # Common model name mappings (user-friendly input -> actual Ollama name)
            name_mappings = {
                'llama3.2-3b': 'llama3.2:3b',
                'llama3_2_3b': 'llama3.2:3b',
                'qwen3-8b': 'qwen3:8b',
                'qwen3_8b': 'qwen3:8b',
                'phi4-14b': 'phi4:14b',
                'phi4_14b': 'phi4:14b',
                'mistral-7b': 'mistral:7b',
                'mistral_7b': 'mistral:7b',
                'gemma3-12b': 'gemma3:12b',
                'gemma3_12b': 'gemma3:12b',
                'gpt-oss-20b': 'gpt-oss:20b',
                'gpt_oss_20b': 'gpt-oss:20b',
                'deepseek-r1-14b': 'deepseek-r1:14b',
                'deepseek_r1_14b': 'deepseek-r1:14b',
            }

            # Try exact mapping first
            if args.model in name_mappings:
                matching_model = name_mappings[args.model]
            else:
                # Try fuzzy matching
                for model in available_models:
                    if model.type == 'ollama':
                        # Remove common separators and compare
                        clean_available = model.name.replace(':', '-').replace('.', '').replace('_', '').lower()
                        clean_input = args.model.replace('-', '_').replace('.', '_').lower()
                        if clean_available == clean_input or clean_input.replace('.', '').replace('-', '').lower() == clean_available:
                            matching_model = model.name
                            break

        if not matching_model:
            print(f"Error: Model '{args.model}' is not available")
            print(f"Available Ollama models:")
            for model in available_models:
                if model.type == 'ollama':
                    print(f"  - {model.name}")
            sys.exit(1)

        print(f"Note: Using '{matching_model}' instead of '{args.model}'")
        models_to_generate = [matching_model]
    else:
        print("Error: Please specify --model, --all, --api-models, --ollama-models, or --list")
        parser.print_help()
        sys.exit(1)

    if not models_to_generate:
        print("Error: No models available for generation")
        sys.exit(1)

    print(f"Models to generate: {len(models_to_generate)}")
    for model in models_to_generate:
        print(f"  - {model}")
    print()

    # Generate for each model
    overall_results = {
        "total_problems": len(problems),
        "models": {}
    }

    for model_name in models_to_generate:
        result = generate_for_model(model_name, problems, args.temperature, args.top_p)
        overall_results["models"][model_name] = result

    # Overall summary
    print(f"\n{'='*60}")
    print("OVERALL SUMMARY")
    print(f"{'='*60}")

    total_success = sum(r["success"] for r in overall_results["models"].values())
    total_possible = len(overall_results["models"]) * len(problems)

    print(f"Total problems: {len(problems)}")
    print(f"Total models: {len(models_to_generate)}")
    print(f"Total possible generations: {total_possible}")
    print(f"Total successful: {total_success}")
    print(f"Success rate: {total_success/total_possible*100:.1f}%")

    print(f"\nModel breakdown:")
    for model_name, result in overall_results["models"].items():
        success_rate = result["success"]/result["total"]*100
        print(f"  {model_name:<20} {result['success']:>3}/{result['total']} ({success_rate:>5.1f}%)")

if __name__ == "__main__":
    main()