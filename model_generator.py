#!/usr/bin/env python3
"""
VerilogEval Model Generator - 统一模型输出脚本

支持Ollama和API模型，生成Verilog代码并保存到results目录。

功能：
- 支持小测试模式（--limit）和全量模式
- 支持分模型测试（--model）
- 支持提示词策略（--prompt-strategy）
- 调用model_interface.py的抽象接口
- 保存模型原始输出到results目录

用法：
    python model_generator.py --all                    # 生成所有模型
    python model_generator.py --model deepseek-v3.2    # 生成指定API模型
    python model_generator.py --model llama3.2-3b      # 生成指定Ollama模型
    python model_generator.py --limit 10               # 小测试模式（前10个问题）
    python model_generator.py --list                   # 列出所有可用模型
    python model_generator.py --list-strategies        # 列出所有可用提示词策略
    python model_generator.py --prompt-strategy v1     # 使用优化提示词策略v1
    python model_generator.py --check-empty            # 检查所有空文件
    python model_generator.py --regenerate-empty       # 检查并重新生成空文件

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
# Prompt Strategies - 优化提示词定义
# ============================================================================
# 将提示词放在文件最开始，方便修改和扩展
# 使用方法：python model_generator.py --prompt-strategy v1

VERILOG_PROMPT_V1 = """You are an expert Verilog/SystemVerilog code generator. Generate ONLY the module body code (the content between the module declaration and endmodule). Follow these CRITICAL SYNTAX RULES:

### CRITICAL SYNTAX RULES - MUST FOLLOW ###

1. **Module Boundary**
   - The module declaration is ALREADY provided in the prompt
   - You MUST end your code with `endmodule`
   - Do NOT redeclare the module header

2. **Continuous Assignment (for combinational logic on wire outputs)**
   - ALWAYS use `assign` keyword for wire-type outputs
   - Correct: `assign out = a & b;`
   - Wrong: `out = a & b;` (missing assign)

3. **Output Port Types**
   - If output is assigned in `always` block -> declare as `reg` or use `logic`
   - If output uses `assign` statement -> leave as `wire` (default)
   - Check the module interface: if output is already declared as `reg`, use always block
   - If output is NOT declared as `reg`, use `assign` for combinational logic

4. **Always Block Assignments**
   - Sequential logic (with clk): use non-blocking `<=`
   - Combinational logic (always @* or always_comb): use blocking `=`
   - NEVER mix blocking and non-blocking in same always block

5. **Signal Declarations**
   - Only use signals that are defined in module ports or declared internally
   - Do NOT use `clk` in combinational-only circuits
   - Check module ports before using any signal

6. **Common Patterns**

   Combinational logic (wire output):
   ```verilog
   assign out = a & b;
   endmodule
   ```

   Combinational logic (reg output, using always):
   ```verilog
   always @(*) begin
       out = a & b;
   end
   endmodule
   ```

   Sequential logic (D flip-flop):
   ```verilog
   always @(posedge clk) begin
       if (reset)
           q <= 1'b0;
       else
           q <= d;
   end
   endmodule
   ```

### OUTPUT FORMAT ###
- Generate ONLY the module body (between declaration and endmodule)
- Must include `endmodule` at the end
- No explanations, no comments unless necessary for complex logic
- No markdown code blocks

### VERIFICATION CHECKLIST ###
Before outputting, verify:
[ ] Code ends with `endmodule`
[ ] All wire outputs use `assign` keyword
[ ] All reg outputs are assigned in always blocks
[ ] Only declared signals are used
[ ] Blocking/non-blocking assignments are correct
"""

# 提示词策略字典 - 在此添加新策略
PROMPT_STRATEGIES = {
    "default": "",  # 原始无优化（基线）
    "v1": VERILOG_PROMPT_V1,  # 语法规则优化 v1
}

# ============================================================================
# Configuration
# ============================================================================

DATASET_DIR = "dataset_code-complete-iccad2023"

# Prompt prefix (from sv-generate) - 基础提示词，所有策略都会保留
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

def prepare_prompt(problem_name: str, prompt_strategy: str = "default") -> tuple:
    """
    Prepare prompt for the problem with optional prompt strategy

    Args:
        problem_name: Name of the problem
        prompt_strategy: Prompt strategy to use (default, v1, etc.)

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

    # 获取策略优化提示词
    strategy_prompt = PROMPT_STRATEGIES.get(prompt_strategy, "")

    # 组合：策略提示词 + 原始基础前缀 + 问题描述
    if strategy_prompt:
        full_prompt = strategy_prompt + "\n\n" + PROMPT_PREFIX + prompt_content
    else:
        full_prompt = PROMPT_PREFIX + prompt_content  # 基线保持不变

    return full_prompt, prompt_content, ifc_content

def find_empty_files(results_dir: str = "results") -> List[Dict]:
    """
    扫描所有结果目录，查找空的.sv文件

    Returns:
        List of dicts with keys: model_dir, problem_name, file_path, temperature, top_p
    """
    import re
    empty_files = []
    results_path = Path(results_dir)

    if not results_path.exists():
        print(f"Error: Results directory '{results_dir}' not found")
        return empty_files

    # Pattern to match directory names with temp and top_p
    pattern = re.compile(r'(.+?)_0shot_temp(.+?)_topP(.+)$')

    for model_dir in results_path.iterdir():
        if not model_dir.is_dir():
            continue

        # Skip analysis directory
        if model_dir.name == "analysis":
            continue

        # Parse directory name for model info
        match = pattern.fullmatch(model_dir.name)
        if not match:
            continue

        model_name, temp_str, top_p_str = match.groups()
        temperature = float(temp_str.replace('_', '.'))
        top_p = float(top_p_str.replace('_', '.'))

        # Scan problem directories
        for problem_dir in model_dir.iterdir():
            if not problem_dir.is_dir():
                continue

            # Skip compile_test_result directory
            if problem_dir.name == "compile_test_result":
                continue

            problem_name = problem_dir.name
            sv_file = problem_dir / f"{problem_name}_sample01.sv"

            if sv_file.exists():
                # Check if file is empty or whitespace-only
                try:
                    content = sv_file.read_text(encoding='utf-8')
                    if not content or not content.strip():
                        empty_files.append({
                            'model_dir': str(model_dir),
                            'model_name': model_name,
                            'problem_name': problem_name,
                            'file_path': str(sv_file),
                            'temperature': temperature,
                            'top_p': top_p
                        })
                except Exception as e:
                    # Try another encoding
                    try:
                        content = sv_file.read_text(encoding='latin-1')
                        if not content or not content.strip():
                            empty_files.append({
                                'model_dir': str(model_dir),
                                'model_name': model_name,
                                'problem_name': problem_name,
                                'file_path': str(sv_file),
                                'temperature': temperature,
                                'top_p': top_p
                            })
                    except:
                        pass

    return empty_files


def check_empty_files(results_dir: str = "results") -> List[Dict]:
    """
    检查并报告所有空文件

    Returns:
        Empty files list
    """
    print("\n检查空文件...")
    print("=" * 60)

    empty_files = find_empty_files(results_dir)

    if not empty_files:
        print("没有发现空文件！所有生成的代码都有内容。")
        return empty_files

    print(f"发现 {len(empty_files)} 个空文件：\n")

    # 按模型分组显示
    from collections import defaultdict
    by_model = defaultdict(list)
    for item in empty_files:
        key = f"{item['model_name']} (temp={item['temperature']}, top_p={item['top_p']})"
        by_model[key].append(item['problem_name'])

    for model_key, problems in by_model.items():
        print(f"\n{model_key}:")
        for problem in problems:
            print(f"  - {problem}")

    print(f"\n{'=' * 60}")
    print(f"总计: {len(empty_files)} 个空文件需要重新生成")

    return empty_files


def regenerate_empty_files(results_dir: str = "results") -> Dict[str, int]:
    """
    检查并重新生成所有空文件

    Returns:
        Dictionary with success/failure counts
    """
    empty_files = check_empty_files(results_dir)

    if not empty_files:
        return {"success": 0, "failed": 0, "total": 0}

    print(f"\n开始重新生成 {len(empty_files)} 个空文件...")
    print("-" * 50)

    success_count = 0
    error_count = 0

    for item in tqdm(empty_files, desc="重新生成"):
        # 需要将model_name转换回实际的模型名称格式
        # 例如：deepseek_v3_2 -> deepseek-v3.2 或其他映射
        model_name_safe = item['model_name']
        problem_name = item['problem_name']
        temperature = item['temperature']
        top_p = item['top_p']

        # 尝试推断原始模型名称
        # 常见的转换规则
        model_name = infer_original_model_name(model_name_safe)

        if not is_model_available(model_name):
            print(f"\n警告: 模型 {model_name} 不可用，跳过 {problem_name}")
            error_count += 1
            continue

        # 删除现有的空文件和相关文件
        problem_dir = Path(item['model_dir']) / problem_name
        for old_file in problem_dir.glob(f"{problem_name}_*"):
            try:
                old_file.unlink()
            except:
                pass

        # 重新生成
        if generate_single_problem(model_name, problem_name, temperature, top_p):
            success_count += 1
        else:
            error_count += 1

        # 小延迟避免过载
        time.sleep(0.5)

    print(f"\n重新生成完成:")
    print(f"  成功: {success_count}")
    print(f"  失败: {error_count}")
    print(f"  总计: {len(empty_files)}")

    return {
        "success": success_count,
        "failed": error_count,
        "total": len(empty_files)
    }


def infer_original_model_name(safe_name: str) -> str:
    """
    从安全目录名称推断原始模型名称

    Args:
        safe_name: 目录安全名称，如 'deepseek_v3_2'

    Returns:
        原始模型名称，如 'deepseek-v3.2'
    """
    # 已知的映射规则
    known_mappings = {
        'deepseek_v3_2': 'deepseek-v3.2',
        'deepseek_r1_14b': 'deepseek-r1:14b',
        'gpt_oss_20b': 'gpt-oss:20b',
        'llama3_2_3b': 'llama3.2:3b',
        'qwen3_8b': 'qwen3:8b',
        'phi4_14b': 'phi4:14b',
        'mistral_7b': 'mistral:7b',
        'gemma3_12b': 'gemma3:12b',
        'glm_4_6': 'glm-4.6',
    }

    if safe_name in known_mappings:
        return known_mappings[safe_name]

    # 尝试通用转换规则
    # 1. 检查是否匹配 Ollama 格式 (name_size)
    import re
    ollama_pattern = re.match(r'(.+?)_(\d+b)$', safe_name, re.IGNORECASE)
    if ollama_pattern:
        name_part = ollama_pattern.group(1).replace('_', '-')
        size_part = ollama_pattern.group(2)
        return f"{name_part}:{size_part}"

    # 2. 默认转换：将下划线转为点或连字符
    return safe_name.replace('_', '-')


def get_model_output_dir(model_name: str, temperature: float = 0.0, top_p: float = 0.01,
                         prompt_strategy: str = "default") -> str:
    """Get output directory for a model, using consistent naming

    Args:
        model_name: Name of the model
        temperature: Generation temperature
        top_p: Generation top_p
        prompt_strategy: Prompt strategy used (default, v1, etc.)

    Returns:
        Output directory path
    """
    # Convert model name to safe directory name (remove file system unsafe characters)
    model_name_safe = model_name.replace(':', '_').replace('-', '_').replace('.', '_')
    # Format temperature and top_p for folder name
    temp_str = str(temperature).replace('.', '_')
    top_p_str = str(top_p).replace('.', '_')

    base_dir = f"results/{model_name_safe}_0shot_temp{temp_str}_topP{top_p_str}"

    # 只有非默认策略才添加后缀（保持向后兼容）
    if prompt_strategy and prompt_strategy != "default":
        base_dir += f"_prompt{prompt_strategy}"

    return base_dir

def generate_single_problem(model_name: str, problem_name: str, temperature: float = 0.0,
                            top_p: float = 0.01, prompt_strategy: str = "default") -> bool:
    """
    Generate code for a single problem using model interface

    Args:
        model_name: Name of the model
        problem_name: Name of the problem
        temperature: Generation temperature
        top_p: Generation top_p
        prompt_strategy: Prompt strategy to use

    Returns:
        True if successful, False otherwise
    """
    try:
        # Prepare prompt with strategy
        full_prompt, prompt_content, ifc_content = prepare_prompt(problem_name, prompt_strategy)

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

def generate_for_model(model_name: str, problems: List[str], temperature: float = 0.0,
                       top_p: float = 0.01, prompt_strategy: str = "default") -> Dict[str, int]:
    """
    Generate code for all problems with a specific model

    Args:
        model_name: Name of the model
        problems: List of problem names
        temperature: Generation temperature
        top_p: Generation top_p
        prompt_strategy: Prompt strategy to use

    Returns:
        Dictionary with success/failure counts
    """
    print(f"\nGenerating code with {model_name}...")
    print(f"Parameters: temperature={temperature}, top_p={top_p}, prompt_strategy={prompt_strategy}")
    print("-" * 50)

    # Get output directory (includes prompt strategy in name if not default)
    output_dir = get_model_output_dir(model_name, temperature, top_p, prompt_strategy)
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
        if generate_single_problem(model_name, problem_name, temperature, top_p, prompt_strategy):
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
  python model_generator.py --list-strategies        # List all available prompt strategies
  python model_generator.py --prompt-strategy v1     # Use optimized prompt strategy v1
  python model_generator.py --limit 10               # Quick test with first 10 problems
  python model_generator.py --start 50              # Start from problem 50 (resume)
  python model_generator.py --check-empty           # Check for empty generated files
  python model_generator.py --regenerate-empty      # Check and regenerate empty files

Prompt Strategy Examples:
  python model_generator.py --model deepseek-v3.2 --prompt-strategy v1
  python model_generator.py --all --prompt-strategy v1 --limit 10
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
    model_group.add_argument(
        '--check-empty',
        action='store_true',
        help='Check for empty generated files'
    )
    model_group.add_argument(
        '--regenerate-empty',
        action='store_true',
        help='Check and regenerate empty files'
    )
    model_group.add_argument(
        '--list-strategies',
        action='store_true',
        help='List all available prompt strategies'
    )

    # Prompt strategy option
    parser.add_argument(
        '--prompt-strategy',
        type=str,
        default='default',
        choices=list(PROMPT_STRATEGIES.keys()),
        help=f'Prompt strategy to use (default: default). Available: {", ".join(PROMPT_STRATEGIES.keys())}'
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

    # Handle list strategies
    if args.list_strategies:
        print("\nAvailable Prompt Strategies:")
        print("=" * 60)
        for strategy_name, strategy_prompt in PROMPT_STRATEGIES.items():
            if strategy_prompt:
                # 显示提示词的前100个字符作为预览
                preview = strategy_prompt[:100].replace('\n', ' ').strip() + "..."
                print(f"\n  {strategy_name}:")
                print(f"    Preview: {preview}")
            else:
                print(f"\n  {strategy_name}: (no optimization - baseline)")
        print("\n" + "=" * 60)
        print("Usage: python model_generator.py --model <model> --prompt-strategy <strategy>")
        return

    # Handle check empty files
    if args.check_empty:
        check_empty_files()
        return

    # Handle regenerate empty files
    if args.regenerate_empty:
        regenerate_empty_files()
        return

    print(f"\nVerilogEval Model Generator")
    print("=" * 50)
    print(f"Dataset: {DATASET_DIR}")
    print(f"Mode: Zero-shot, temp={args.temperature}, top_p={args.top_p}")
    print(f"Prompt Strategy: {args.prompt_strategy}")

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
        "prompt_strategy": args.prompt_strategy,
        "models": {}
    }

    for model_name in models_to_generate:
        result = generate_for_model(model_name, problems, args.temperature, args.top_p, args.prompt_strategy)
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