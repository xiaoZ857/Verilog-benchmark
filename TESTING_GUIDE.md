# VerilogEval 测试指引

## 📋 概述

本指引介绍如何使用 VerilogEval 测试框架来评估大语言模型生成 Verilog 代码的能力。

## 🚀 快速开始

### 1. 环境检查
```bash
python test_suite.py check
```
这会检查所需的工具是否已安装：
- Python 3.11+
- iverilog v12
- ollama (如需测试在线模型)

### 2. 模型检查
```bash
python test_suite.py models
```
检查可用的 Ollama 模型及其状态。

### 3. 运行测试
```bash
# 测试所有模型（完整测试，约1-2小时）
python test_suite.py test-all

# 快速测试单个模型（10个问题）
python test_suite.py test --model phi4:14b --limit 10

# 从特定问题开始测试
python test_suite.py test --model phi4:14b --start 100 --limit 50
```

### 4. 分析结果
```bash
# 生成最新分析报告
python test_suite.py analyze

# 查看修正后的准确结果
cat results/corrected_test_results.txt
```

### 5. 查看状态
```bash
python test_suite.py status
```

## 🔧 详细功能说明

### 核心测试脚本

#### `test_suite.py` - 统一测试接口
提供所有测试功能的统一入口，支持以下命令：

- **`check`**: 检查环境依赖
- **`models`**: 检查模型可用性
- **`test`**: 测试单个模型
- **`test-all`**: 测试所有模型
- **`analyze`**: 分析测试结果
- **`status`**: 显示当前状态

#### `run_verilog_eval.py` - 核心测试引擎
- 使用 Ollama API 生成 Verilog 代码
- 自动进行编译和仿真测试
- 集成静态分析，防止卡死
- 保存详细的测试日志

#### `static_analyzer.py` - 静态分析器
自动检测会导致仿真卡死的代码模式：
- 直接组合逻辑环路
- 复杂的反馈回路
- 不安全的时钟使用

#### `analyze_results.py` - 结果分析器
分析测试结果并生成报告：
- 文本格式报告
- CSV 数据表格
- JSON 详细数据

## 📊 测试结果解读

### 输出文件结构
```
results/
├── corrected_test_results.txt    # 修正后的汇总报告
├── corrected_test_results.csv     # CSV格式数据
├── corrected_test_results.json    # 详细JSON数据
├── [model]_0shot_temp0.0/         # 各模型结果目录
│   ├── Prob001_zero/
│   │   ├── Prob001_zero_sample01.sv              # 生成的代码
│   │   ├── Prob001_zero_sample01_raw_response.txt # 原始响应
│   │   └── Prob001_zero_sample01-sv-iv-test_RETEST.log # 测试日志
│   └── ... (其他问题)
```

### 关键指标解释

- **编译成功率**：代码语法正确，能成功编译的比例
- **测试通过率**：功能正确，通过所有测试用例的比例
- **COMPILE FAIL**：编译失败（语法错误）
- **TEST FAIL**：编译成功但功能错误
- **PASS**：编译成功且功能正确

### 真实性能示例（修正后）

⚠️ **重要说明**: 原始测试框架存在执行错误，导致所有模型显示0%通过率。已修复此问题，真实性能如下：

```
Model              Pass@1     Compiled   通过/总数
--------------------------------------------------
gpt-oss:20b        56.4%      59.6%      88/156
phi4:14b           30.8%      68.6%      48/156
gemma3:12b         28.2%      53.8%      44/156
qwen3:8b           17.3%      17.9%      27/156
deepseek-r1:14b    9.6%       12.8%      15/156
llama3.2:3b        9.6%       30.8%      15/156
mistral:7b         9.0%       21.8%      14/156
```

**关键修复**:
- 修复测试执行命令（使用 `vvp` 而非直接执行）
- 添加静态分析器防止卡死
- 集成到主测试引擎中

**查看修正结果**: `cat results/corrected_test_results.txt`

## 🎯 测试配置

### 模型配置
在 `run_all_models.py` 中配置要测试的模型：

```python
MODELS = [
    "llama3.2:3b",
    "mistral:7b",
    "qwen3:8b",
    "gemma3:12b",
    "deepseek-r1:14b",
    "phi4:14b",
    "gpt-oss:20b",
]
```

### 生成参数
- **温度**: 0.0（确定性输出）
- **Top-p**: 0.01（低随机性）
- **最大Token**: 1024
- **提示**: 零样本（无上下文示例）

### 测试数据集
- **来源**: `dataset_code-complete-iccad2023/`
- **问题数**: 156个
- **类型**: Verilog代码补全任务
- **验证**: 包含编译和功能测试

## 🔍 故障排除

### 常见问题

#### 1. 环境问题
```bash
# 检查 iverilog
iverilog -v

# 检查 ollama
ollama list

# 检查 Python 包
pip install ollama tqdm
```

#### 2. 模型不可用
```bash
# 拉取所需模型
ollama pull phi4:14b
ollama pull llama3.2:3b
```

#### 3. 编译错误
确保使用 iverilog v12，不支持 v13 开发版本。

#### 4. 测试卡死
静态分析器会自动检测和跳过会导致卡死的代码，但如果仍然遇到问题：

```bash
# 检查卡死的具体问题
python static_analyzer.py results/[model]/[problem]/[file].sv
```

### 调试模式

#### 单问题测试
```bash
python run_verilog_eval.py --model phi4:14b --limit 1
```

#### 查看详细日志
```bash
# 查看具体问题的测试日志
cat results/phi4_14b_0shot_temp0.0/Prob001_zero/Prob001_zero_sample01-sv-iv-test_RETEST.log
```

## 📈 性能优化建议

### 系统资源
- **内存**: 建议 16GB+ RAM
- **存储**: 至少 10GB 可用空间
- **CPU**: 多核CPU可并行处理

### 测试策略
1. **快速验证**: 使用 `--limit 10` 测试少量问题
2. **分批测试**: 使用 `--start` 和 `--limit` 分段测试
3. **并行处理**: 使用 `-j4` 参数进行4进程编译（如果支持）

### 结果验证
```bash
# 重新分析结果
python analyze_results.py --results-dir results --output final_analysis

# 检查特定模型
python analyze_results.py --model phi4_14b_0shot_temp0.0
```

## 📝 最佳实践

### 1. 测试前准备
- 确保所有依赖已正确安装
- 验证模型可用性
- 检查磁盘空间充足

### 2. 测试执行
- 从小规模测试开始
- 监控系统资源使用
- 定期检查中间结果

### 3. 结果分析
- 重点关注测试通过率而非仅编译成功率
- 分析失败案例的错误模式
- 比较不同模型的性能差异

### 4. 报告生成
- 保存原始测试数据
- 生成多种格式的报告
- 记录测试环境和参数

## 🔧 扩展功能

### 添加新模型
在 `run_all_models.py` 的 `MODELS` 列表中添加：
```python
MODELS = [
    # 现有模型...
    "new_model:latest",  # 添加新模型
]
```

### 自定义测试数据
- 将新的测试问题放入 `dataset_code-complete-iccad2023/`
- 遵循命名格式：`Prob[编号]_[描述]`

### 修改静态分析规则
在 `static_analyzer.py` 中添加新的检测模式：
```python
# 添加新的检测模式
def will_hang_simulation(verilog_code: str):
    # 现有检测...

    # 新检测模式
    if "dangerous_pattern" in verilog_code:
        return True, "Dangerous pattern detected"

    return False, None
```

## 📞 支持与反馈

如果遇到问题或需要帮助：

1. 检查本文档的故障排除部分
2. 查看测试日志中的详细错误信息
3. 确认环境配置正确
4. 验证模型可用性

## 🎓 学习资源

- [Verilog 语言参考](https://www.verilog.com/)
- [iverilog 文档](http://iverilog.icarus.com/)
- [Ollama 文档](https://github.com/ollama/ollama)

---

**注意**: 本测试框架已修复原始测试中的执行错误，现在能准确反映模型的实际Verilog代码生成能力。