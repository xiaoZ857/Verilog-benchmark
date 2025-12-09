#!/usr/bin/env python3
"""
VerilogEval Results Analyzer - 失败分析和统计分类工具

专注于分析模型的编译失败和测试失败原因，提供详细的错误分类和统计。

功能：
- 扫描results目录中的所有模型结果
- 分析编译失败的具体原因和模式
- 分析测试失败的行为模式
- 生成详细的HTML分析报告
- 按温度和top_p参数组织结果

用法：
    python results_analyzer.py                         # 分析所有模型
    python results_analyzer.py --temp 0.8 --top-p 0.95 # 分析特定参数
    python results_analyzer.py --temp 0.0             # 分析下限测试
    python results_analyzer.py --stats-only           # 仅生成统计信息

SPDX-FileCopyrightText: Copyright (c) 2024
SPDX-License-Identifier: MIT
"""

import sys
import os
import json
import glob
import argparse
import re
import time
from typing import List, Dict, Optional, Tuple, Set
from dataclasses import dataclass, asdict
from pathlib import Path
from collections import defaultdict, Counter
import html

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
class CompilationFailure:
    """编译失败的详细信息"""
    problem_name: str
    error_type: str  # 'syntax', 'semantic', 'static_analysis', 'timeout'
    error_message: str
    error_pattern: str  # 提取的关键错误模式
    line_number: Optional[int] = None
    code_snippet: Optional[str] = None

@dataclass
class TestFailure:
    """测试失败的详细信息"""
    problem_name: str
    failure_type: str  # 'functionality', 'timing', 'assertion', 'simulation_error'
    test_pattern: str  # 测试失败的模式
    description: str
    reference_diff: Optional[str] = None

@dataclass
class ModelAnalysis:
    """单个模型的分析结果"""
    model_name: str
    temperature: float
    top_p: float
    total_problems: int
    generated: int
    compiled: int
    passed: int
    compilation_failures: List[CompilationFailure]
    test_failures: List[TestFailure]
    static_analysis_failures: List[str]

    @property
    def compile_rate(self) -> float:
        return (self.compiled / self.total_problems * 100) if self.total_problems > 0 else 0.0

    @property
    def pass_rate(self) -> float:
        return (self.passed / self.total_problems * 100) if self.total_problems > 0 else 0.0

    @property
    def generation_rate(self) -> float:
        return (self.generated / self.total_problems * 100) if self.total_problems > 0 else 0.0

@dataclass
class UnifiedAnalysis:
    """统一分析结果（同一参数下的所有模型）"""
    temperature: float
    top_p: float
    models: List[ModelAnalysis]
    compilation_error_patterns: Dict[str, int]  # 错误模式 -> 出现次数
    test_failure_patterns: Dict[str, int]  # 失败模式 -> 出现次数
    hardest_problems: List[Tuple[str, float]]  # (problem_name, pass_rate)
    easiest_problems: List[Tuple[str, float]]  # (problem_name, pass_rate)

# ============================================================================
# Utility Functions
# ============================================================================

def find_result_directories(temp_filter: Optional[float] = None,
                           top_p_filter: Optional[float] = None) -> List[Tuple[str, float, float]]:
    """Find all model result directories with temperature and top_p parameters"""
    results_dir = Path("results")
    if not results_dir.exists():
        print("Error: results/ directory not found")
        return []

    # Pattern to match directory names with temp and top_p
    # Format: model_name_0shot_tempX_X_topPX_X
    pattern = re.compile(r'(.+?)_0shot_temp(.+?)_topP(.+)$')

    model_dirs = []
    for item in results_dir.iterdir():
        if item.is_dir():
            match = pattern.fullmatch(item.name)
            if match:
                model_name, temp_str, top_p_str = match.groups()

                # Convert string representations back to numbers
                temp = float(temp_str.replace('_', '.'))
                top_p = float(top_p_str.replace('_', '.'))

                # Apply filters
                if temp_filter is not None and abs(temp - temp_filter) > 1e-6:
                    continue
                if top_p_filter is not None and abs(top_p - top_p_filter) > 1e-6:
                    continue

                # Check if this directory contains model results
                sample01_files = list(item.glob("*/*_sample01.sv"))
                if sample01_files:
                    model_dirs.append((str(item), temp, top_p))

    return sorted(model_dirs, key=lambda x: (x[1], x[2], x[0]))

def extract_model_name(directory: str) -> str:
    """从目录路径中提取模型名称"""
    dir_name = os.path.basename(directory)
    # 移除后缀
    match = re.match(r'(.+?)_0shot_temp', dir_name)
    if match:
        return match.group(1)
    return dir_name

def get_problem_list() -> List[str]:
    """从数据集目录获取所有问题列表"""
    if not os.path.exists("dataset_code-complete-iccad2023"):
        print("Warning: dataset directory not found, using file counting")
        return []

    prompt_files = sorted(Path("dataset_code-complete-iccad2023").glob("*_prompt.txt"))
    problems = []
    for file in prompt_files:
        basename = os.path.basename(file)
        problem_name = basename[:-11]  # 移除 _prompt.txt 后缀
        problems.append(problem_name)

    return problems

def read_log_file(log_path: str) -> Optional[str]:
    """读取日志文件内容"""
    encodings = ['utf-8', 'gbk', 'gb2312', 'latin-1']

    for encoding in encodings:
        try:
            with open(log_path, 'r', encoding=encoding) as f:
                return f.read()
        except UnicodeDecodeError:
            continue
        except Exception as e:
            print(f"Warning: Could not read log file {log_path}: {e}")
            return None

    print(f"Warning: Could not decode log file {log_path} with any encoding")
    return None

def read_compiled_sv_file(sv_path: str) -> Optional[str]:
    """读取编译后的SV文件内容"""
    encodings = ['utf-8', 'gbk', 'gb2312', 'latin-1']

    for encoding in encodings:
        try:
            with open(sv_path, 'r', encoding=encoding) as f:
                return f.read()
        except UnicodeDecodeError:
            continue
        except Exception as e:
            print(f"Warning: Could not read SV file {sv_path}: {e}")
            return None

    print(f"Warning: Could not decode SV file {sv_path} with any encoding")
    return None

def read_generated_code(problem_dir: str, problem_name: str) -> Optional[str]:
    """读取生成的代码"""
    extracted_file = os.path.join(problem_dir, f"{problem_name}_sample01_extracted_code.txt")
    sv_file = os.path.join(problem_dir, f"{problem_name}_sample01.sv")

    # 优先读取提取的代码，如果不存在或为空则读取完整SV文件
    for file_path in [extracted_file, sv_file]:
        if os.path.exists(file_path):
            encodings = ['utf-8', 'gbk', 'gb2312', 'latin-1']
            for encoding in encodings:
                try:
                    with open(file_path, 'r', encoding=encoding) as f:
                        content = f.read()
                        # 如果内容非空则返回，否则继续尝试下一个文件
                        if content and content.strip():
                            return content
                        break  # 文件成功读取但为空，跳出编码循环，尝试下一个文件
                except UnicodeDecodeError:
                    continue
                except Exception as e:
                    print(f"Warning: Could not read {file_path}: {e}")
                    break  # 读取错误，尝试下一个文件

    return None

# ============================================================================
# Analysis Functions
# ============================================================================

def read_compile_test_results_json(model_dir: str) -> Optional[Dict]:
    """读取compile_test_results.json文件"""
    json_path = os.path.join(model_dir, "compile_test_result", "compile_test_results.json")
    if os.path.exists(json_path):
        try:
            with open(json_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        except Exception as e:
            print(f"Warning: Could not read JSON file {json_path}: {e}")
    return None

def classify_compilation_error(log_content: str) -> Tuple[str, str, Optional[int], str]:
    """
    分类编译错误

    Returns:
        (error_type, error_pattern, line_number, code_snippet)
    """
    lines = log_content.split('\n')
    error_type = "unknown"
    error_pattern = ""
    line_number = None
    code_snippet = ""

    # 常见错误模式
    error_patterns = {
        "syntax": [
            r"syntax error",
            r"unexpected token",
            r"malformed statement",
            r"expecting.*found",
            r"invalid token",
            r"missing.*;",
            r"parentheses.*not balanced",
            r"module.*endmodule mismatch"
        ],
        "semantic": [
            r"undeclared.*identifier",
            r"redeclaration",
            r"multiple.*drivers",
            r"width mismatch",
            r"invalid.*assignment",
            r"constant.*expression",
            r"port.*mismatch",
            r"parameter.*mismatch"
        ],
        "static_analysis": [
            r"STATIC FAILED",
            r"infinite loop detected",
            r"combinatorial loop",
            r"feedback loop",
            r"cycle detection",
            r"self-referential"
        ]
    }

    # 查找错误类型和行号
    for i, line in enumerate(lines):
        line_lower = line.lower()

        # 检查静态分析失败
        if "static failed" in line_lower or "infinite loop" in line_lower:
            error_type = "static_analysis"
            error_pattern = "Static analysis detected problematic code"
            return error_type, error_pattern, None, ""

        # 查找其他错误模式
        for err_type, patterns in error_patterns.items():
            for pattern in patterns:
                if re.search(pattern, line_lower, re.IGNORECASE):
                    error_type = err_type

                    # 提取行号
                    line_match = re.search(r'line\s+(\d+)', line_lower)
                    if line_match:
                        line_number = int(line_match.group(1))

                    # 提取错误描述
                    error_pattern = line.strip()

                    # 获取代码片段
                    if line_number and i + 5 < len(lines):
                        snippet_lines = []
                        for j in range(max(0, i-2), min(len(lines), i+3)):
                            snippet_lines.append(lines[j])
                        code_snippet = '\n'.join(snippet_lines)

                    return error_type, error_pattern, line_number, code_snippet

    # 如果没有找到明确模式，尝试从iverilog错误中提取
    for line in lines:
        if ":" in line and ("error" in line.lower() or "warning" in line.lower()):
            error_pattern = line.strip()
            if "syntax" in line.lower():
                error_type = "syntax"
            elif "semantic" in line.lower() or re.search(r'(undeclared|redeclaration|multiple|width)', line.lower()):
                error_type = "semantic"
            break

    return error_type, error_pattern, line_number, code_snippet

def classify_test_failure(log_content: str, problem_name: str) -> Tuple[str, str]:
    """
    分类测试失败

    Returns:
        (failure_type, description)
    """
    lines = log_content.split('\n')
    failure_type = "unknown"
    description = ""

    # 常见测试失败模式
    failure_patterns = {
        "functionality": [
            r"tb_match.*failed",
            r"assertion.*failed",
            r"test.*failed",
            r"incorrect.*output",
            r"value.*mismatch"
        ],
        "timing": [
            r"timing.*violation",
            r"setup.*time",
            r"hold.*time",
            r"clock.*skew"
        ],
        "assertion": [
            r"assertion.*error",
            r"assert.*failed",
            r"property.*failed",
            r"cover.*failed"
        ],
        "simulation_error": [
            r"fatal.*error",
            r"simulation.*aborted",
            r"runtime.*error",
            r"memory.*overflow"
        ]
    }

    # 分析失败类型
    for line in lines:
        line_lower = line.lower()

        for fail_type, patterns in failure_patterns.items():
            for pattern in patterns:
                if re.search(pattern, line_lower, re.IGNORECASE):
                    failure_type = fail_type
                    description = line.strip()
                    return failure_type, description

    # 检查特定的verilog测试失败模式
    for line in lines:
        if "tb_match" in line.lower():
            if "=== 0" in line or "=== 1" in line:
                failure_type = "functionality"
                description = "Output mismatch detected in testbench comparison"
                break

    return failure_type, description

def analyze_model_directory(model_dir: str, temperature: float, top_p: float) -> ModelAnalysis:
    """分析单个模型目录"""
    model_name = extract_model_name(model_dir)
    model_path = Path(model_dir)

    print(f"分析 {model_name} (temp={temperature}, top_p={top_p})...")

    # 初始化统计
    total_problems = len(get_problem_list())
    generated = 0
    compiled = 0
    passed = 0
    compilation_failures = []
    test_failures = []
    static_analysis_failures = []

    # 尝试读取预先计算的JSON结果
    json_results = read_compile_test_results_json(model_dir)

    # compile_test_result目录路径
    compile_result_dir = model_path / "compile_test_result"

    # 遍历所有问题目录
    for problem_dir in model_path.iterdir():
        if not problem_dir.is_dir():
            continue

        # 跳过compile_test_result目录
        if problem_dir.name == "compile_test_result":
            continue

        problem_name = problem_dir.name

        # 检查是否生成了代码（检查.sv文件是否存在且非空）
        sv_file = problem_dir / f"{problem_name}_sample01.sv"
        if sv_file.exists():
            try:
                content = sv_file.read_text(encoding='utf-8')
                if content and content.strip():
                    generated += 1
            except:
                try:
                    content = sv_file.read_text(encoding='latin-1')
                    if content and content.strip():
                        generated += 1
                except:
                    pass

    # 如果有JSON结果，使用JSON中的编译和通过数据
    if json_results:
        compiled = json_results.get('compiled', 0)
        passed = json_results.get('passed', 0)
        # JSON中的generated应该与我们计算的一致，但以实际文件为准
        # 分析编译失败的详情
        failed_compilation = json_results.get('failed_compilation', [])
        failed_tests = json_results.get('failed_tests', [])

        # 从compile_test_result目录读取失败日志
        for problem_name in failed_compilation:
            # 尝试读取编译失败日志
            compile_log = compile_result_dir / f"{problem_name}_compile_failed.log"
            if compile_log.exists():
                log_content = read_log_file(str(compile_log))
                if log_content:
                    error_type, error_pattern, line_num, code_snippet = classify_compilation_error(log_content)
                    compilation_failures.append(CompilationFailure(
                        problem_name=problem_name,
                        error_type=error_type,
                        error_message=error_pattern,
                        error_pattern=extract_error_pattern(error_pattern),
                        line_number=line_num,
                        code_snippet=code_snippet
                    ))

        for problem_name in failed_tests:
            # 尝试读取测试失败日志
            test_log = compile_result_dir / f"{problem_name}_failed.log"
            if test_log.exists():
                log_content = read_log_file(str(test_log))
                if log_content:
                    failure_type, description = classify_test_failure(log_content, problem_name)
                    test_failures.append(TestFailure(
                        problem_name=problem_name,
                        failure_type=failure_type,
                        test_pattern=extract_test_pattern(log_content),
                        description=description
                    ))
    else:
        # 没有JSON，从日志文件分析
        for problem_dir in model_path.iterdir():
            if not problem_dir.is_dir() or problem_dir.name == "compile_test_result":
                continue

            problem_name = problem_dir.name

            # 查找日志文件（可能有不同的命名格式和位置）
            log_file = None
            possible_locations = [
                (problem_dir, f"{problem_name}-sv-iv-test.log"),
                (problem_dir, f"{problem_name}_sample01-sv-iv-test.log"),
            ]

            for log_dir, log_name in possible_locations:
                potential_log = log_dir / log_name
                if potential_log.exists():
                    log_file = potential_log
                    break

            log_content = read_log_file(str(log_file)) if log_file else ""

            if log_content:
                # 分析编译结果
                compile_match = re.search(r'=== Compilation ===.*?Return code: (\d+)', log_content, re.DOTALL)
                if compile_match and int(compile_match.group(1)) == 0:
                    compiled += 1

                    # 分析测试结果
                    test_match = re.search(r'Mismatches: (\d+) in \d+ samples', log_content)
                    if test_match and int(test_match.group(1)) == 0:
                        passed += 1
                    else:
                        # 测试失败
                        failure_type, description = classify_test_failure(log_content, problem_name)
                        test_failures.append(TestFailure(
                            problem_name=problem_name,
                            failure_type=failure_type,
                            test_pattern=extract_test_pattern(log_content),
                            description=description
                        ))
                else:
                    # 编译失败
                    error_type, error_pattern, line_num, code_snippet = classify_compilation_error(log_content)
                    compilation_failures.append(CompilationFailure(
                        problem_name=problem_name,
                        error_type=error_type,
                        error_message=error_pattern,
                        error_pattern=extract_error_pattern(error_pattern),
                        line_number=line_num,
                        code_snippet=code_snippet
                    ))

                # 检查静态分析失败
                if "SKIP: Simulation-hanging pattern detected" in log_content:
                    static_analysis_failures.append(problem_name)

    return ModelAnalysis(
        model_name=model_name,
        temperature=temperature,
        top_p=top_p,
        total_problems=total_problems,
        generated=generated,
        compiled=compiled,
        passed=passed,
        compilation_failures=compilation_failures,
        test_failures=test_failures,
        static_analysis_failures=static_analysis_failures
    )

def extract_error_pattern(error_message: str) -> str:
    """从错误消息中提取关键模式"""
    # 移除行号、文件名等具体信息，保留错误类型
    patterns = [
        r'line\s+\d+:\s*',  # 移除行号
        r'[^:]*:\s*',       # 移除文件名
        r'\s+at\s+\S+',     # 移除位置信息
    ]

    pattern = error_message
    for p in patterns:
        pattern = re.sub(p, '', pattern)

    return pattern.strip()

def extract_test_pattern(log_content: str) -> str:
    """从测试日志中提取失败模式"""
    # 查找与tb_match相关的关键信息
    tb_match_lines = [line for line in log_content.split('\n') if 'tb_match' in line]
    if tb_match_lines:
        return tb_match_lines[-1].strip()

    # 查找包含关键信号信息的行
    signal_lines = []
    for line in log_content.split('\n'):
        if any(keyword in line.lower() for keyword in ['mismatch', 'error', 'failed', 'assert']):
            signal_lines.append(line.strip())

    return signal_lines[-1] if signal_lines else "Unknown pattern"

def analyze_unified_results(models: List[ModelAnalysis], temperature: float, top_p: float) -> UnifiedAnalysis:
    """生成统一分析"""
    compilation_error_patterns = defaultdict(int)
    test_failure_patterns = defaultdict(int)

    # 统计错误模式
    for model in models:
        for failure in model.compilation_failures:
            compilation_error_patterns[failure.error_pattern] += 1

        for failure in model.test_failures:
            test_failure_patterns[failure.test_pattern] += 1

    # 分析最难和最简单的问题
    problem_stats = defaultdict(lambda: {'total': 0, 'passed': 0})

    for model in models:
        # 转换模型名称格式以匹配目录名
        model_name_safe = model.model_name.replace('.', '_').replace('-', '_')
        # 格式化温度和top_p参数
        temp_str = str(temperature).replace('.', '_')
        top_p_str = str(top_p).replace('.', '_')
        model_dir = Path(f"results/{model_name_safe}_0shot_temp{temp_str}_topP{top_p_str}")

        if model_dir.exists():
            for problem_dir in model_dir.iterdir():
                if problem_dir.is_dir():
                    problem_name = problem_dir.name
                    problem_stats[problem_name]['total'] += 1

                    # 检查是否通过
                    log_file = None
                    possible_names = [
                        f"{problem_name}-sv-iv-test.log",
                        f"{problem_name}_sample01-sv-iv-test.log"
                    ]

                    for log_name in possible_names:
                        potential_log = problem_dir / log_name
                        if potential_log.exists():
                            log_file = potential_log
                            break

                    if log_file:
                        log_content = read_log_file(str(log_file))
                        if log_content:
                            # 检查编译是否成功
                            compile_match = re.search(r'=== Compilation ===.*?Return code: (\d+)', log_content, re.DOTALL)
                            if compile_match and int(compile_match.group(1)) == 0:
                                # 检查测试是否通过
                                test_match = re.search(r'Mismatches: (\d+) in \d+ samples', log_content)
                                if test_match and int(test_match.group(1)) == 0:
                                    problem_stats[problem_name]['passed'] += 1

    # 计算通过率并排序
    problem_rates = []
    for problem_name, stats in problem_stats.items():
        if stats['total'] > 0:
            pass_rate = stats['passed'] / stats['total'] * 100
            problem_rates.append((problem_name, pass_rate))

    # 按通过率排序
    hardest = sorted(problem_rates, key=lambda x: x[1])[:10]  # 最难的10个
    easiest = sorted(problem_rates, key=lambda x: x[1], reverse=True)[:10]  # 最简单的10个

    return UnifiedAnalysis(
        temperature=temperature,
        top_p=top_p,
        models=models,
        compilation_error_patterns=dict(compilation_error_patterns),
        test_failure_patterns=dict(test_failure_patterns),
        hardest_problems=hardest,
        easiest_problems=easiest
    )

# ============================================================================
# HTML Report Generation
# ============================================================================

def generate_css_styles() -> str:
    """生成CSS样式"""
    return """
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
            margin-bottom: 30px;
        }
        h2 {
            color: #34495e;
            margin-top: 30px;
            margin-bottom: 15px;
            border-left: 4px solid #3498db;
            padding-left: 15px;
        }
        h3 {
            color: #7f8c8d;
            margin-top: 25px;
            margin-bottom: 10px;
        }
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .summary-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }
        .summary-card h3 {
            margin: 0 0 10px 0;
            color: white;
        }
        .summary-card .value {
            font-size: 2em;
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #34495e;
            color: white;
            font-weight: 600;
        }
        tr:hover {
            background-color: #f8f9fa;
        }
        .error-type {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85em;
            font-weight: 600;
            text-transform: uppercase;
        }
        .error-syntax { background-color: #e74c3c; color: white; }
        .error-semantic { background-color: #f39c12; color: white; }
        .error-static_analysis { background-color: #9b59b6; color: white; }
        .error-unknown { background-color: #95a5a6; color: white; }
        .failure-functionality { background-color: #e67e22; color: white; }
        .failure-timing { background-color: #3498db; color: white; }
        .failure-assertion { background-color: #2ecc71; color: white; }
        .failure-simulation_error { background-color: #c0392b; color: white; }
        .code-snippet {
            background-color: #2c3e50;
            color: #ecf0f1;
            padding: 15px;
            border-radius: 5px;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            overflow-x: auto;
            margin: 10px 0;
        }
        .error-details {
            margin: 15px 0;
            padding: 15px;
            background-color: #fdf2f2;
            border-left: 4px solid #e74c3c;
            border-radius: 0 5px 5px 0;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .stats-card {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }
        .problem-list {
            list-style: none;
            padding: 0;
        }
        .problem-list li {
            padding: 8px 12px;
            margin: 4px 0;
            background-color: #f8f9fa;
            border-radius: 4px;
            border-left: 3px solid #3498db;
        }
        .model-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
        }
        .model-link:hover {
            text-decoration: underline;
        }
        .chart-container {
            margin: 20px 0;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        .progress-bar {
            background-color: #e9ecef;
            border-radius: 10px;
            overflow: hidden;
            height: 20px;
            margin: 5px 0;
        }
        .progress-fill {
            background: linear-gradient(90deg, #3498db, #2ecc71);
            height: 100%;
            transition: width 0.3s ease;
        }
        .back-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 20px;
            display: inline-block;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
    """

def generate_unified_analysis_html(analysis: UnifiedAnalysis, output_path: str):
    """生成统一分析HTML报告"""

    def get_rate_class(rate):
        if rate >= 80:
            return "style='background-color: #2ecc71; color: white;'"
        elif rate >= 60:
            return "style='background-color: #f39c12; color: white;'"
        else:
            return "style='background-color: #e74c3c; color: white;'"

    html_content = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>VerilogEval 失败分析报告 - Temp {analysis.temperature} TopP {analysis.top_p}</title>
        <meta charset="utf-8">
        {generate_css_styles()}
    </head>
    <body>
        <div class="container">
            <h1>VerilogEval 失败分析报告</h1>
            <p><strong>参数配置:</strong> Temperature = {analysis.temperature}, Top_p = {analysis.top_p}</p>
            <p><strong>生成时间:</strong> {time.strftime('%Y-%m-%d %H:%M:%S')}</p>

            <h2>[性能概览] 模型性能概览</h2>
            <table>
                <thead>
                    <tr>
                        <th>模型</th>
                        <th>生成率</th>
                        <th>编译率</th>
                        <th>通过率</th>
                        <th>编译失败</th>
                        <th>测试失败</th>
                        <th>详细分析</th>
                    </tr>
                </thead>
                <tbody>
    """

    for model in analysis.models:
        html_content += f"""
                    <tr>
                        <td><strong>{model.model_name}</strong></td>
                        <td {get_rate_class(model.generation_rate)}>{model.generation_rate:.1f}%</td>
                        <td {get_rate_class(model.compile_rate)}>{model.compile_rate:.1f}%</td>
                        <td {get_rate_class(model.pass_rate)}>{model.pass_rate:.1f}%</td>
                        <td>{len(model.compilation_failures)}</td>
                        <td>{len(model.test_failures)}</td>
                        <td><a href="model_details/{model.model_name}_details.html" class="model-link">查看详情</a></td>
                    </tr>
        """

    html_content += """
                </tbody>
            </table>

            <h2>[编译分析] 编译错误模式分析</h2>
            <div class="stats-grid">
    """

    # 编译错误模式统计
    if analysis.compilation_error_patterns:
        sorted_errors = sorted(analysis.compilation_error_patterns.items(), key=lambda x: x[1], reverse=True)
        html_content += f"""
                <div class="stats-card">
                    <h3>最常见的编译错误</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>错误模式</th>
                                <th>出现次数</th>
                                <th>分布</th>
                            </tr>
                        </thead>
                        <tbody>
        """

        max_count = max(sorted_errors, key=lambda x: x[1])[1] if sorted_errors else 1

        for pattern, count in sorted_errors[:10]:  # 显示前10个
            percentage = (count / max_count) * 100
            html_content += f"""
                            <tr>
                                <td>{html.escape(pattern)}</td>
                                <td>{count}</td>
                                <td>
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="width: {percentage}%"></div>
                                    </div>
                                </td>
                            </tr>
            """

        html_content += """
                        </tbody>
                    </table>
                </div>
        """
    else:
        html_content += "<div class='stats-card'><p>没有发现编译错误模式</p></div>"

    # 测试失败模式统计
    html_content += """
                <div class="stats-card">
                    <h3>测试失败模式分析</h3>
    """

    if analysis.test_failure_patterns:
        sorted_failures = sorted(analysis.test_failure_patterns.items(), key=lambda x: x[1], reverse=True)
        html_content += f"""
                    <table>
                        <thead>
                            <tr>
                                <th>失败模式</th>
                                <th>出现次数</th>
                                <th>分布</th>
                            </tr>
                        </thead>
                        <tbody>
        """

        max_count = max(sorted_failures, key=lambda x: x[1])[1] if sorted_failures else 1

        for pattern, count in sorted_failures[:10]:  # 显示前10个
            percentage = (count / max_count) * 100
            html_content += f"""
                            <tr>
                                <td>{html.escape(pattern)}</td>
                                <td>{count}</td>
                                <td>
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="width: {percentage}%"></div>
                                    </div>
                                </td>
                            </tr>
            """

        html_content += """
                        </tbody>
                    </table>
        """
    else:
        html_content += "<p>没有发现测试失败模式</p>"

    html_content += "</div></div>"

    # 最难和最简单的问题
    html_content += """
            <div class="stats-grid">
                <div class="stats-card">
                    <h3>[最难题] 最具挑战性的问题 (通过率最低)</h3>
                    <ul class="problem-list">
    """

    for problem_name, pass_rate in analysis.hardest_problems[:10]:
        html_content += f"<li><strong>{problem_name}</strong> - 通过率: {pass_rate:.1f}%</li>"

    html_content += """
                    </ul>
                </div>

                <div class="stats-card">
                    <h3>[简单题] 最简单的问题 (通过率最高)</h3>
                    <ul class="problem-list">
    """

    for problem_name, pass_rate in analysis.easiest_problems[:10]:
        html_content += f"<li><strong>{problem_name}</strong> - 通过率: {pass_rate:.1f}%</li>"

    html_content += """
                    </ul>
                </div>
            </div>
        </div>
    </body>
    </html>
    """

    # 确保输出目录存在
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    # 写入文件
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(html_content)

def generate_model_detail_html(model: ModelAnalysis, output_path: str, unified_report_path: str):
    """生成单个模型的详细分析HTML报告"""

    relative_unified_path = os.path.relpath(unified_report_path, os.path.dirname(output_path))

    html_content = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <title>{model.model_name} 详细分析报告</title>
        <meta charset="utf-8">
        {generate_css_styles()}
    </head>
    <body>
        <div class="container">
            <a href="{relative_unified_path}" class="back-link">← 返回统一分析</a>

            <h1>{model.model_name} 详细分析报告</h1>
            <p><strong>参数配置:</strong> Temperature = {model.temperature}, Top_p = {model.top_p}</p>
            <p><strong>生成时间:</strong> {time.strftime('%Y-%m-%d %H:%M:%S')}</p>

            <div class="summary-grid">
                <div class="summary-card">
                    <h3>总问题数</h3>
                    <div class="value">{model.total_problems}</div>
                </div>
                <div class="summary-card" style="background: linear-gradient(135deg, #2ecc71, #27ae60);">
                    <h3>生成成功率</h3>
                    <div class="value">{model.generation_rate:.1f}%</div>
                    <p>{model.generated}/{model.total_problems}</p>
                </div>
                <div class="summary-card" style="background: linear-gradient(135deg, #3498db, #2980b9);">
                    <h3>编译成功率</h3>
                    <div class="value">{model.compile_rate:.1f}%</div>
                    <p>{model.compiled}/{model.total_problems}</p>
                </div>
                <div class="summary-card" style="background: linear-gradient(135deg, #e74c3c, #c0392b);">
                    <h3>测试通过率</h3>
                    <div class="value">{model.pass_rate:.1f}%</div>
                    <p>{model.passed}/{model.total_problems}</p>
                </div>
            </div>
    """

    # 编译失败详情
    if model.compilation_failures:
        html_content += """
            <h2>[编译失败] 编译失败详情</h2>
        """

        for failure in model.compilation_failures:
            html_content += f"""
            <div class="error-details">
                <h3>{failure.problem_name}</h3>
                <p><span class="error-type error-{failure.error_type}">{failure.error_type}</span></p>
                <p><strong>错误信息:</strong> {html.escape(failure.error_message)}</p>
                <p><strong>错误模式:</strong> {html.escape(failure.error_pattern)}</p>
            """

            if failure.line_number:
                html_content += f"<p><strong>行号:</strong> {failure.line_number}</p>"

            if failure.code_snippet:
                html_content += f"""
                <p><strong>代码片段:</strong></p>
                <div class="code-snippet">{html.escape(failure.code_snippet)}</div>
                """

            html_content += "</div>"
    else:
        html_content += "<h2>[编译成功] 编译失败</h2><p>没有编译失败的情况</p>"

    # 测试失败详情
    if model.test_failures:
        html_content += """
            <h2>[测试失败] 测试失败详情</h2>
        """

        for failure in model.test_failures:
            html_content += f"""
            <div class="error-details" style="border-left-color: #f39c12;">
                <h3>{failure.problem_name}</h3>
                <p><span class="error-type failure-{failure.failure_type}">{failure.failure_type}</span></p>
                <p><strong>失败描述:</strong> {html.escape(failure.description)}</p>
                <p><strong>失败模式:</strong> {html.escape(failure.test_pattern)}</p>
            </div>
            """
    else:
        html_content += "<h2>[测试成功] 测试失败</h2><p>没有测试失败的情况</p>"

    # 静态分析失败
    if model.static_analysis_failures:
        html_content += f"""
            <h2>[静态分析] 静态分析失败</h2>
            <p>以下问题被静态分析器标记为可能存在问题：</p>
            <ul>
        """

        for problem in model.static_analysis_failures:
            html_content += f"<li>{problem}</li>"

        html_content += "</ul>"
    else:
        html_content += "<h2>[静态分析] 静态分析</h2><p>所有问题都通过了静态分析检查</p>"

    html_content += """
        </div>
    </body>
    </html>
    """

    # 确保输出目录存在
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    # 写入文件
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(html_content)

# ============================================================================
# Main Function
# ============================================================================

def main():
    parser = argparse.ArgumentParser(
        description="分析 VerilogEval 结果，专注于失败分析和统计分类",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  python results_analyzer.py                           # 分析所有参数配置
  python results_analyzer.py --temp 0.8 --top-p 0.95   # 分析特定参数
  python results_analyzer.py --temp 0.0               # 分析下限测试
  python results_analyzer.py --stats-only             # 仅生成统计信息
        """
    )

    parser.add_argument(
        '--temp',
        type=float,
        help='过滤特定温度参数'
    )
    parser.add_argument(
        '--top-p',
        type=float,
        dest='top_p',
        help='过滤特定top_p参数'
    )
    parser.add_argument(
        '--stats-only',
        action='store_true',
        help='仅生成统计信息，不生成详细报告'
    )

    args = parser.parse_args()

    print("VerilogEval 失败分析工具")
    print("=" * 50)

    start_time = time.time()

    # 查找所有结果目录
    result_dirs = find_result_directories(args.temp, args.top_p)

    if not result_dirs:
        print("没有找到匹配的结果目录")
        sys.exit(1)

    print(f"找到 {len(result_dirs)} 个结果目录")

    # 按温度和top_p分组
    groups = defaultdict(list)
    for dir_path, temp, top_p in result_dirs:
        groups[(temp, top_p)].append((dir_path, temp, top_p))

    print(f"发现 {len(groups)} 个参数配置组合")

    # 为每个参数组合生成分析
    for (temp, top_p), directories in groups.items():
        print(f"\n{'='*60}")
        print(f"分析参数配置: Temperature = {temp}, Top_p = {top_p}")
        print(f"{'='*60}")

        # 创建输出目录结构
        analysis_dir = f"results/analysis/temp{temp}_topP{top_p}"
        model_details_dir = os.path.join(analysis_dir, "model_details")
        os.makedirs(model_details_dir, exist_ok=True)

        # 分析所有模型
        models = []
        for dir_path, model_temp, model_top_p in directories:
            model_analysis = analyze_model_directory(dir_path, model_temp, model_top_p)
            models.append(model_analysis)

        # 生成统一分析
        unified_analysis = analyze_unified_results(models, temp, top_p)

        if not args.stats_only:
            # 生成统一分析HTML报告
            unified_report_path = os.path.join(analysis_dir, "unified_analysis.html")
            generate_unified_analysis_html(unified_analysis, unified_report_path)
            print(f"[完成] 生成统一分析报告: {unified_report_path}")

            # 为每个模型生成详细报告
            for model in models:
                model_report_path = os.path.join(model_details_dir, f"{model.model_name}_details.html")
                generate_model_detail_html(model, model_report_path, unified_report_path)
                print(f"  [完成] 生成模型详情报告: {model.model_name}_details.html")

        # 打印详细统计表格
        print(f"\n[统计] 参数配置 {temp}/{top_p} 详细结果:")
        print(f"{'模型名称':<20} {'生成成功率':>10} {'编译成功率':>10} {'测试通过率':>10} {'通过/总数':>10}")
        print("-" * 70)

        # 按通过率排序
        sorted_models = sorted(models, key=lambda m: m.pass_rate, reverse=True)
        for model in sorted_models:
            print(f"{model.model_name:<20} {model.generation_rate:>9.1f}% {model.compile_rate:>9.1f}% {model.pass_rate:>9.1f}% {model.passed:>4}/{model.total_problems:<4}")

        print("-" * 70)
        avg_pass_rate = sum(m.pass_rate for m in models) / len(models)
        avg_compile_rate = sum(m.compile_rate for m in models) / len(models)
        print(f"{'平均':>20} {'-':>10} {avg_compile_rate:>9.1f}% {avg_pass_rate:>9.1f}%")
        print(f"\n  总编译错误模式: {len(unified_analysis.compilation_error_patterns)}")
        print(f"  总测试失败模式: {len(unified_analysis.test_failure_patterns)}")

    print(f"\n{'='*60}")
    print(f"分析完成，耗时 {time.time() - start_time:.2f} 秒")
    print(f"{'='*60}")

if __name__ == "__main__":
    main()