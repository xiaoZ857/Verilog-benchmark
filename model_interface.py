#!/usr/bin/env python3
"""
VerilogEval Model Interface - 统一模型接口调用脚本

提供统一的接口来调用不同类型的模型（Ollama和API模型），包括：
- 模型可用性检查
- 代码生成调用
- 统一的输出格式

支持的模型类型：
- Ollama模型（本地运行）
- API模型（DeepSeek, GLM-4.6等）

用法：
    from model_interface import generate_code_for_problem
    success = generate_code_for_problem("llama3.2-3b", "Prob001_zero", prompt, interface)

SPDX-FileCopyrightText: Copyright (c) 2024
SPDX-License-Identifier: MIT
"""

import os
import sys
import json
import time
import subprocess
import requests
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass

# Try to import OpenAI SDK for DeepSeek
try:
    from openai import OpenAI
    OPENAI_AVAILABLE = True
except ImportError:
    OPENAI_AVAILABLE = False

# ============================================================================
# Configuration
# ============================================================================

# API Keys configuration file
API_CONFIG_FILE = "api_keys.json"

# Supported API models configuration
API_MODELS = {
    "deepseek-v3.2": {
        "name": "deepseek-v3.2",
        "type": "api",
        "api_type": "deepseek",
        "base_url": "https://api.deepseek.com/v1",
        "model_name": "deepseek-chat",  # Non-thinking mode
        "max_tokens": 1024,
        "temperature": 0.0,
        "top_p": 0.01
    },
    "glm-4.6": {
        "name": "glm-4.6",
        "type": "api",
        "api_type": "zhipuai",
        "base_url": "https://open.bigmodel.cn/api/paas/v4",
        "model_name": "glm-4.6",
        "max_tokens": 1024,
        "temperature": 0.0,
        "top_p": 0.01
    }
}

# System message for code-complete task (from sv-generate)
SYSTEM_MSG = """You only complete chats with syntax correct Verilog code. End the Verilog module code completion with 'endmodule'. Do not include module, input and output definitions."""

# ============================================================================
# Data Classes
# ============================================================================

@dataclass
class ModelInfo:
    """Model information"""
    name: str
    type: str  # "ollama" or "api"
    available: bool = False
    description: Optional[str] = None

@dataclass
class GenerationResult:
    """Result from code generation"""
    success: bool
    response_text: Optional[str] = None
    generation_time: float = 0.0
    error_message: Optional[str] = None

# ============================================================================
# API Key Management
# ============================================================================

def load_api_keys() -> Dict[str, str]:
    """Load API keys from configuration file"""
    if not os.path.exists(API_CONFIG_FILE):
        return {}

    try:
        with open(API_CONFIG_FILE, 'r') as f:
            data = json.load(f)

        keys = {}
        for api_type, key_info in data.items():
            keys[api_type] = key_info['key']

        return keys
    except Exception as e:
        print(f"Error loading API keys: {e}")
        return {}

# ============================================================================
# Ollama Model Interface
# ============================================================================

def check_ollama_service() -> bool:
    """Check if Ollama service is running"""
    try:
        result = subprocess.run(['ollama', 'list'], capture_output=True, text=True, timeout=10)
        return result.returncode == 0
    except (FileNotFoundError, subprocess.TimeoutExpired):
        return False

def get_ollama_models() -> List[str]:
    """Get list of available Ollama models"""
    try:
        result = subprocess.run(['ollama', 'list'], capture_output=True, text=True, timeout=10)
        if result.returncode == 0:
            lines = result.stdout.strip().split('\n')
            models = []
            for line in lines[1:]:  # Skip header
                if line.strip():
                    parts = line.split()
                    if parts:
                        # Replace colon with underscore for consistent naming
                        model_name = parts[0].replace(':', '_')
                        models.append(model_name)
            return models
    except (FileNotFoundError, subprocess.TimeoutExpired, Exception):
        pass
    return []

def call_ollama_api(model_name: str, prompt: str) -> GenerationResult:
    """Call Ollama HTTP API for code generation"""
    start_time = time.time()

    try:
        # Use Ollama HTTP API instead of CLI
        response = requests.post(
            "http://localhost:11434/api/generate",
            json={
                "model": model_name,
                "prompt": prompt,
                "stream": False,
                "options": {
                    "temperature": 0.0,
                    "top_p": 0.01,
                    "num_predict": 1024
                }
            },
            timeout=120
        )

        end_time = time.time()
        generation_time = end_time - start_time

        if response.status_code == 200:
            result = response.json()
            response_text = result.get('response', '')

            return GenerationResult(
                success=True,
                response_text=response_text,
                generation_time=generation_time
            )
        else:
            return GenerationResult(
                success=False,
                generation_time=generation_time,
                error_message=f"Ollama API error: {response.status_code} - {response.text}"
            )

    except requests.exceptions.Timeout:
        return GenerationResult(
            success=False,
            generation_time=time.time() - start_time,
            error_message="Ollama API timeout"
        )
    except Exception as e:
        return GenerationResult(
            success=False,
            generation_time=time.time() - start_time,
            error_message=f"Ollama API call failed: {str(e)}"
        )

# ============================================================================
# API Model Interface
# ============================================================================

def call_deepseek_api(api_key: str, prompt: str, model_config: Dict) -> GenerationResult:
    """Call DeepSeek API for code generation using OpenAI SDK"""
    if not OPENAI_AVAILABLE:
        return GenerationResult(
            success=False,
            error_message="OpenAI SDK not installed. Install with: pip install openai"
        )

    start_time = time.time()

    try:
        # Create OpenAI client for DeepSeek
        client = OpenAI(
            api_key=api_key,
            base_url=model_config["base_url"]
        )

        response = client.chat.completions.create(
            model=model_config["model_name"],
            messages=[
                {"role": "system", "content": SYSTEM_MSG},
                {"role": "user", "content": prompt}
            ],
            max_tokens=model_config["max_tokens"],
            temperature=model_config["temperature"],
            top_p=model_config["top_p"],
            stream=False
        )

        end_time = time.time()
        generation_time = end_time - start_time

        if response.choices and len(response.choices) > 0:
            response_text = response.choices[0].message.content
            return GenerationResult(
                success=True,
                response_text=response_text,
                generation_time=generation_time
            )
        else:
            return GenerationResult(
                success=False,
                generation_time=generation_time,
                error_message="No response choices returned"
            )

    except Exception as e:
        return GenerationResult(
            success=False,
            generation_time=time.time() - start_time,
            error_message=f"DeepSeek API call failed: {str(e)}"
        )

def call_glm_api(api_key: str, prompt: str, model_config: Dict) -> GenerationResult:
    """Call GLM API for code generation"""
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    data = {
        "model": model_config["model_name"],
        "messages": [
            {"role": "system", "content": SYSTEM_MSG},
            {"role": "user", "content": prompt}
        ],
        "temperature": model_config["temperature"],
        "top_p": model_config["top_p"],
        "max_tokens": model_config["max_tokens"],
        "stream": False
    }

    start_time = time.time()

    try:
        response = requests.post(
            f"{model_config['base_url']}/chat/completions",
            headers=headers,
            json=data,
            timeout=120
        )

        end_time = time.time()
        generation_time = end_time - start_time

        if response.status_code == 200:
            result = response.json()

            if "choices" in result and len(result["choices"]) > 0:
                response_text = result["choices"][0]["message"]["content"]
                return GenerationResult(
                    success=True,
                    response_text=response_text,
                    generation_time=generation_time
                )
            else:
                return GenerationResult(
                    success=False,
                    generation_time=generation_time,
                    error_message="Invalid response format: no choices found"
                )
        else:
            return GenerationResult(
                success=False,
                generation_time=generation_time,
                error_message=f"GLM API error: {response.status_code} - {response.text}"
            )

    except requests.exceptions.Timeout:
        return GenerationResult(
            success=False,
            generation_time=time.time() - start_time,
            error_message="GLM API request timeout"
        )
    except Exception as e:
        return GenerationResult(
            success=False,
            generation_time=time.time() - start_time,
            error_message=f"GLM API request failed: {str(e)}"
        )

# ============================================================================
# Code Generation Interface
# ============================================================================

def extract_verilog_code(response: str, module_interface: str) -> Tuple[str, str]:
    """
    Extract Verilog code from model response

    Returns:
        (complete_code_with_interface, extracted_code_only)
    """
    lines = response.splitlines()

    # First pass: check for backticks and module definition
    backticks_count = 0
    module_already_exists = False
    endmodule_before_startmodule = False

    for line in lines:
        if line.startswith("```"):
            backticks_count += 1
        elif line.startswith("endmodule"):
            if not module_already_exists:
                endmodule_before_startmodule = True
        elif line.startswith("module TopModule"):
            module_already_exists = True

    if endmodule_before_startmodule:
        module_already_exists = False

    # Extract code
    extracted_lines = []
    found_first_backticks = False
    found_second_backticks = False
    found_module = False
    found_endmodule = False

    for line in lines:
        echo_line = True

        if line.strip().startswith("module TopModule"):
            found_module = True

        if backticks_count >= 2:
            if (not found_first_backticks) or found_second_backticks:
                echo_line = False
        else:
            if found_endmodule:
                echo_line = False
            if module_already_exists and not found_module:
                echo_line = False

        if line.startswith("```"):
            if not found_first_backticks:
                found_first_backticks = True
            else:
                found_second_backticks = True
            echo_line = False
        elif line.strip().startswith("endmodule"):
            found_endmodule = True

        if echo_line:
            extracted_lines.append(line)

    extracted_code = "\n".join(extracted_lines)

    # Build complete code with interface if needed
    if not module_already_exists:
        complete_code = "\n" + module_interface + "\n" + extracted_code + "\n"
    else:
        complete_code = "\n" + extracted_code + "\n"

    # Add warnings if needed
    warnings = []
    if backticks_count == 1 or backticks_count > 2:
        warnings.append("// VERILOG-EVAL: abnormal backticks count")
    if found_module:
        warnings.append("// VERILOG-EVAL: errant inclusion of module definition")
    if not found_endmodule:
        warnings.append("// VERILOG-EVAL: endmodule not found")

    if warnings:
        complete_code += "\n" + "\n".join(warnings) + "\n"

    return complete_code, extracted_code

def generate_code_for_problem(model_name: str, problem_name: str, prompt: str, interface: str) -> bool:
    """
    Generate code for a specific problem using specified model

    Args:
        model_name: Name of the model to use
        problem_name: Name of the problem
        prompt: Full prompt for the model
        interface: Module interface code

    Returns:
        True if successful, False otherwise
    """
    try:
        # Determine model type and call appropriate API
        if model_name in API_MODELS:
            # API model
            model_config = API_MODELS[model_name]
            api_type = model_config["api_type"]

            # Load API keys
            keys = load_api_keys()
            if api_type not in keys:
                print(f"Error: API key not configured for {api_type}")
                return False

            # Call API
            if api_type == "deepseek":
                result = call_deepseek_api(keys[api_type], prompt, model_config)
            elif api_type == "zhipuai":
                result = call_glm_api(keys[api_type], prompt, model_config)
            else:
                print(f"Error: Unsupported API type: {api_type}")
                return False

        else:
            # Ollama model
            if not check_ollama_service():
                print(f"Error: Ollama service not available")
                return False

            result = call_ollama_api(model_name, prompt)

        if not result.success:
            print(f"Error generating code for {problem_name}: {result.error_message}")
            return False

        # Extract code
        complete_code, extracted_code = extract_verilog_code(result.response_text, interface)

        # Save files in Ollama-compatible format
        model_name_safe = model_name.replace('-', '_').replace('.', '_')
        output_dir = f"results/{model_name_safe}_0shot_temp0.0"
        problem_dir = os.path.join(output_dir, problem_name)

        os.makedirs(problem_dir, exist_ok=True)

        # Save raw response
        raw_file = f"{problem_dir}/{problem_name}_sample01_raw_response.txt"
        with open(raw_file, 'w') as f:
            f.write(result.response_text)

        # Save extracted code
        extracted_file = f"{problem_dir}/{problem_name}_sample01_extracted_code.txt"
        with open(extracted_file, 'w') as f:
            f.write(extracted_code)

        # Save complete code
        complete_file = f"{problem_dir}/{problem_name}_sample01.sv"
        with open(complete_file, 'w') as f:
            f.write(complete_code)

        return True

    except Exception as e:
        print(f"Error in generate_code_for_problem: {str(e)}")
        return False

# ============================================================================
# Model Discovery Interface
# ============================================================================

def get_available_models() -> List[ModelInfo]:
    """Get list of all available models"""
    models = []

    # Get API models
    api_keys = load_api_keys()
    for model_name, config in API_MODELS.items():
        api_type = config["api_type"]
        available = api_type in api_keys
        models.append(ModelInfo(
            name=model_name,
            type="api",
            available=available,
            description=f"{config['model_name']} via {api_type}"
        ))

    # Get Ollama models
    if check_ollama_service():
        ollama_models = get_ollama_models()
        for model_name in ollama_models:
            models.append(ModelInfo(
                name=model_name,
                type="ollama",
                available=True,
                description="Local Ollama model"
            ))

    return models

def is_model_available(model_name: str) -> bool:
    """Check if a specific model is available"""
    if model_name in API_MODELS:
        # API model - check if API key is configured
        model_config = API_MODELS[model_name]
        api_type = model_config["api_type"]
        keys = load_api_keys()
        return api_type in keys
    else:
        # Ollama model - check if available in Ollama
        if check_ollama_service():
            ollama_models = get_ollama_models()
            return model_name in ollama_models
        return False

# ============================================================================
# Command Line Interface (for testing)
# ============================================================================

def main():
    """Command line interface for testing model interface"""
    import argparse

    parser = argparse.ArgumentParser(description="Test model interface")
    parser.add_argument('--list', action='store_true', help='List available models')
    parser.add_argument('--test', nargs=2, metavar=('MODEL', 'PROMPT'), help='Test model generation')

    args = parser.parse_args()

    if args.list:
        models = get_available_models()
        print("Available Models:")
        for model in models:
            status = "✓" if model.available else "✗"
            print(f"  {status} {model.name} ({model.type}) - {model.description}")

    elif args.test:
        model_name, prompt_file = args.test
        if not os.path.exists(prompt_file):
            print(f"Error: Prompt file not found: {prompt_file}")
            sys.exit(1)

        with open(prompt_file, 'r') as f:
            prompt = f.read()

        interface = """module TopModule (
    output test
);"""

        success = generate_code_for_problem(model_name, "test_problem", prompt, interface)
        print(f"Generation {'successful' if success else 'failed'}")

    else:
        parser.print_help()

if __name__ == "__main__":
    main()