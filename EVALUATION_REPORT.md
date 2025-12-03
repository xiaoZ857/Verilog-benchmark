# VerilogEval 大语言模型 Verilog 代码生成能力测评报告

## 📋 测评概述

### 测评目标
评估当前主流大语言模型在 Verilog 硬件描述语言代码生成任务中的表现，特别是在数字电路设计任务中的准确性和实用性。

### 测评日期
2024年12月3日

## 🧪 评估方法

### 数据集结构

#### 基础数据集
- **来源**: VerilogEval 官方数据集
- **数据集名称**: `dataset_code-complete-iccad2023`
- **问题总数**: 156个 Verilog 设计问题
- **任务类型**: 数字电路代码补全任务

#### 数据集文件结构
每个测试问题包含以下文件：
- `Prob*_prompt.txt`: 问题描述和模块接口定义
- `Prob*_test.sv`: 功能验证测试文件
- `Prob*_ref.sv`: 参考实现（标准答案）
- `Prob*_ifc.txt`: 模块接口定义文件

### 问题示例

#### 示例问题：Prob001_zero（恒定低电平输出）

**问题描述文件** (`Prob001_zero_prompt.txt`):
```
Build a circuit that always outputs a LOW.

module TopModule (
  output zero
);

```

**参考实现** (`Prob001_zero_ref.sv`):
```verilog
module RefModule (
  output zero
);

  assign zero = 1'b0;

endmodule
```

**测试文件** (`Prob001_zero_test.sv`):
```verilog
module tb();
  wire zero_ref;
  wire zero_dut;

  RefModule good1 (.zero(zero_ref));
  TopModule top_module1 (.zero(zero_dut));

  assign tb_match = ( { zero_ref } === ( { zero_ref } ^ { zero_dut } ^ { zero_ref } ) );

  always @(posedge clk, negedge clk) begin
    if (!tb_match) begin
      stats1.errors++;
    end
  end
endmodule
```

### 提示词设计

#### 系统消息
```
You only complete chats with syntax correct Verilog code. End the Verilog module code completion with 'endmodule'. Do not include module, input and output definitions.
```

#### 提示前缀
```
// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.
```

**提示前缀的作用**：
- 提供标准化的指导，告诉模型这是一个Verilog代码生成任务
- 明确说明时序假设（默认上升沿触发），避免时序逻辑错误
- 建立统一的编程风格和约定

#### 完整提示示例
以 Prob001_zero 为例，发送给模型的完整提示包括系统消息、提示前缀和问题描述：

**Ollama API 调用格式**：
```
[
  {"role": "system", "content": "You only complete chats with syntax correct Verilog code. End the Verilog module code completion with 'endmodule'. Do not include module, input and output definitions."},
  {"role": "user", "content": "// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.\nBuild a circuit that always outputs a LOW.\n\nmodule TopModule (\n  output zero\n);\n"}
]
```

模型需要补全从 `module` 定义开始到 `endmodule` 结束的完整 Verilog代码。

### 评估模型

| 模型名称 | 参数规模 | 提供商 | 类型 |
|---------|---------|--------|------|
| llama3.2:3b | 3B | Meta | 开源 |
| mistral:7b | 7B | Mistral AI | 开源 |
| qwen3:8b | 8B | 阿里云 | 开源 |
| gemma3:12b | 12B | Google | 开源 |
| deepseek-r1:14b | 14B | DeepSeek | 开源 |
| phi4:14b | 14B | Microsoft | 开源 |
| gpt-oss:20b | 20B | 开源社区 | 开源 |

### 评估参数
- **温度**: 0.0（确定性输出）
- **Top-p**: 0.01（低随机性）
- **最大Token数**: 1024
- **采样方式**: 零样本（0-shot），无上下文示例
- **每个问题**: 生成1个样本（temperature=0）

### 评估流程

#### 单个问题评估流程
1. **代码生成**: 将提示词发送给模型，生成 Verilog 代码补全
2. **代码提取**: 从模型响应中提取 Verilog 代码
3. **静态检查**: 使用静态分析器检测可能导致仿真卡死的代码模式（原评估代码中的bug，添加这个机制修好了）
4. **代码组装**: 将提取的代码与模块接口组装成完整文件
5. **编译测试**: 使用 iverilog 编译生成的代码
6. **功能验证**: 运行仿真测试，与参考实现进行对比
7. **结果记录**: 记录编译状态、测试通过情况和详细日志

#### 完整评估流程示例

以 Prob001_zero 问题为例，展示完整的评估流程：

**步骤 1: 代码生成**
```
发送给 Ollama API 的完整请求：
[
  {"role": "system", "content": "You only complete chats with syntax correct Verilog code. End the Verilog module code completion with 'endmodule'. Do not include module, input and output definitions."},
  {"role": "user", "content": "// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.\nBuild a circuit that always outputs a LOW.\n\nmodule TopModule (\n  output zero\n);\n"}
]

模型响应：
"  assign zero = 1'b0;\n\nendmodule"
```

**步骤 2: 代码提取**
```
提取的 Verilog 代码：
assign zero = 1'b0;

endmodule
```

**步骤 3: 静态检查**
```
静态分析器检查结果：
- 未检测到组合逻辑环路
- 未检测到不安全的时钟使用
- 允许进入编译阶段
```

**步骤 4: 代码组装**
```
完整测试文件 (Prob001_zero_sample01.sv):
`include "Prob001_zero_test.sv"

module TopModule (
  output zero
);

  assign zero = 1'b0;

endmodule
```

**步骤 5: 编译测试**
```
编译命令: iverilog -o Prob001_zero_sample01.bin Prob001_zero_sample01.sv
编译结果: 成功 (无语法错误)
```

**步骤 6: 功能验证**
```
仿真命令: vvp Prob001_zero_sample01.bin
仿真结果: PASS (输出与参考实现一致)
```

**步骤 7: 结果记录**
```
记录结果:
- 编译状态: SUCCESS
- 测试状态: PASS
- 总体判定: 通过测试
- 详细日志: 保存至 Prob001_zero_sample01-sv-iv-test.log
```

#### 静态过滤器增强

**背景问题**: 在测试过程中发现某些模型生成的代码包含组合逻辑环路（如 `assign out = (clk && ~out) ^ in;`），导致仿真无限循环卡死。

**解决方案**: 集成了静态分析器来检测和过滤可能导致仿真卡死的代码模式：

**检测模式**:
- 直接组合逻辑环路：信号在 assign 语句中自我引用
- 复杂反馈回路：多信号形成的循环依赖
- 不安全的时钟使用：可能导致竞争条件的时钟模式

**处理流程**:
1. 在编译前对生成的代码进行静态分析
2. 如果检测到危险模式，跳过仿真测试并标记为 "STATIC FAILED"
3. 记录具体的失败原因到日志文件
4. 确保评估框架能够稳定运行，避免因个别问题导致整体测试中断

**效果**: 静态过滤器的加入确保了评估框架的稳定性，能够处理所有 156 个测试问题而不会因卡死而中断，同时保留了评估结果的有效性。

#### 评估标准
- **编译成功**: 代码语法正确，能成功编译
- **测试通过**: 功能完全正确，与参考实现输出一致
- **最终判定**: 只有编译成功且测试通过才计为成功

## 📊 测评结果

### 模型性能统计

| 模型名称 | 参数规模 | 编译成功率 | **测试通过率** | 通过/总数 |
|---------|---------|-----------|--------------|----------|
| gpt-oss:20b | 20B | 59.6% | **56.4%** | 88/156 |
| phi4:14b | 14B | 68.6% | **30.8%** | 48/156 |
| gemma3:12b | 12B | 53.8% | **28.2%** | 44/156 |
| qwen3:8b | 8B | 17.9% | **17.3%** | 27/156 |
| deepseek-r1:14b | 14B | 12.8% | **9.6%** | 15/156 |
| llama3.2:3b | 3B | 30.8% | **9.6%** | 15/156 |
| mistral:7b | 7B | 21.8% | **9.0%** | 14/156 |

## 📊 数据说明

### 结果文件位置
```
results/
├── corrected_test_results.txt     # 汇总报告
├── corrected_test_results.csv      # CSV格式数据
├── corrected_test_results.json     # JSON详细数据
└── [model]_0shot_temp0.0/         # 各模型详细结果
```

### 每个测试案例包含的文件
- `*_raw_response.txt`: 模型原始响应
- `*_extracted_code.txt`: 提取的Verilog代码
- `*.sv`: 完整的测试代码文件
- `*-sv-iv-test.log`: 编译和测试日志

### 评估参数记录
- **生成温度**: 0.0（确定性输出）
- **最大Token数**: 1024
- **采样方式**: 零样本（0-shot）
- **测试环境**: Windows + iverilog v12
- **评估日期**: 2024年12月3日

---

**数据来源**: VerilogEval官方数据集
**数据可用性**: 开源，遵循MIT许可证