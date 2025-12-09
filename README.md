# VerilogEval Benchmark 测试结果记录

## 原始数据集简介

基于 VerilogEval 官方数据集（ICCAD 2023），包含 156 个 Verilog 数字电路设计问题，用于评估大语言模型的 Verilog 代码生成能力。

- **数据集**: `dataset_code-complete-iccad2023`
- **问题数量**: 156 个
- **任务类型**: 代码补全
- **评估工具**: iverilog v12

每个问题包含：
- `Prob*_prompt.txt`: 问题描述和模块接口
- `Prob*_test.sv`: 功能验证测试
- `Prob*_ref.sv`: 参考实现

## 测试结果记录

### 代码补全任务 (Code Completion)

#### 模型下限测试

**测试配置**:
- 温度参数: 0.0（使用贪心算法，确定性输出）
- top-p: 0.01（该参数此时无作用）
- 采样方式: 零样本（0-shot）
- 最大Token数: 1024
- 测试环境: Windows + iverilog v12
- Python版本: 3.13.9
- 硬件配置: Intel i7-12700KF + RTX 5060Ti 16GB
- 评估工具: iverilog + vvp + 静态过滤器（防无限循环卡死）

**测试结果**:

| 模型名称 | 参数规模 | 生成成功率 | 编译成功率 | 测试通过率 | 通过/总数 |
|---------|---------|-----------|-----------|------------|----------|
| gpt-oss_20b | 20B | 100% | 59.6% | 56.4% | 88/156 |
| deepseek_v3_2 | API | 100% | 59.0% | 46.2% | 72/156 |
| phi4_14b | 14B | 100% | 68.6% | 30.1% | 47/156 |
| gemma3_12b | 12B | 100% | 53.8% | 28.2% | 44/156 |
| glm_4_6 | API | 100% | 26.3% | 25.0% | 39/156 |
| qwen3_8b | 8B | 100% | 17.9% | 17.3% | 27/156 |
| deepseek-r1_14b | 14B | 100% | 12.8% | 9.6% | 15/156 |
| llama3.2_3b | 3B | 100% | 30.8% | 9.6% | 15/156 |
| mistral_7b | 7B | 100% | 21.8% | 9.0% | 14/156 |

**关键发现**:
- gpt-oss:20b 表现最佳，测试通过率 56.4%
- 参数规模与性能不完全正相关，模型架构和训练质量更为重要
- phi4:14b 编译成功率最高（68.6%），但通过率仅为 30.1%，说明编译成功不等于功能正确


#### 模型上限测试

**测试配置**:
- 温度参数: 0.8（增加多样性）
- top-p: 0.95（更自由的采样）
- 采样方式: 零样本（0-shot）
- 最大Token数: 1024
- 测试环境: Windows + iverilog v12
- Python版本: 3.13.9
- 硬件配置: Intel i7-12700KF + RTX 5060Ti 16GB
- 评估工具: iverilog + vvp + 静态过滤器（防无限循环卡死）

**测试结果**:

| 模型名称 | 参数规模 | 生成成功率 | 编译成功率 | 测试通过率 | 通过/总数 |
|---------|---------|-----------|-----------|------------|----------|
| deepseek_v3_2 | API | 100% | 59.0% | 48.7% | 76/156 |
| gpt_oss_20b | 20B | 100% | 42.9% | 41.7% | 65/156 |
| phi4_14b | 14B | 100% | 76.9% | 39.7% | 62/156 |
| gemma3_12b | 12B | 100% | 67.3% | 37.2% | 58/156 |
| glm_4_6 | API | 100% | 28.8% | 25.0% | 39/156 |
| deepseek-r1_14b | 14B | 100% | 16.0% | 15.4% | 24/156 |
| qwen3_8b | 8B | 100% | 10.3% | 10.3% | 16/156 |
| mistral_7b | 7B | 100% | 17.3% | 5.1% | 8/156 |
| llama3.2_3b | 3B | 100% | 17.9% | 4.5% | 7/156 |

**关键发现**:
- **deepseek_v3_2 表现最佳**，相比下限测试提升了3.2个百分点（从45.5%到48.7%）
- **所有模型生成成功率均为100%**，说明高温参数并未影响模型理解任务能力
- **phi4_14b 编译成功率最高**（76.9%），但通过率相对较低，与下限测试保持一致
- **模型性能与参数规模大致正相关**，除了glm-4.6外，其他的模型整体按照模型参数越大通过率越高的规律
- **高温参数整体提升了模型性能**，相比下限测试有显著改善，特别是API模型和开源大模型提升幅度更明显
- **qwen3_8b 编译和测试通过率完全一致**（10.3%），说明其生成的代码要么完全正确要么完全错误，没有中间状态

## 评估方法

### 数据集结构

每个问题包含：
- `Prob*_prompt.txt`: 问题描述和模块接口定义
- `Prob*_test.sv`: 功能验证测试文件
- `Prob*_ref.sv`: 参考实现（标准答案）
- `Prob*_ifc.txt`: 模块接口定义文件

**问题示例：Prob001_zero（恒定低电平输出）**

问题描述 (`Prob001_zero_prompt.txt`):
```
Build a circuit that always outputs a LOW.

module TopModule (
  output zero
);
```

参考实现 (`Prob001_zero_ref.sv`):
```verilog
module RefModule (
  output zero
);
  assign zero = 1'b0;
endmodule
```

测试文件 (`Prob001_zero_test.sv`):
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

### 提示词格式

**系统消息**:
```
You only complete chats with syntax correct Verilog code. End the Verilog module code completion with 'endmodule'. Do not include module, input and output definitions.
```

**用户提示**:
```
// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.
[问题描述]

module TopModule (
  [端口定义]
);
```

**完整 API 调用示例**:
```json
[
  {"role": "system", "content": "You only complete chats with syntax correct Verilog code. End the Verilog module code completion with 'endmodule'. Do not include module, input and output definitions."},
  {"role": "user", "content": "// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.\nBuild a circuit that always outputs a LOW.\n\nmodule TopModule (\n  output zero\n);\n"}
]
```

### 评估流程

1. **代码生成**: 发送提示词给模型生成 Verilog 代码
2. **代码提取**: 从模型响应中提取纯净的 Verilog 代码
3. **静态检查**: 检测可能导致仿真卡死的代码模式
4. **代码组装**: 将生成的代码与模块接口组装成完整文件
5. **编译测试**: 使用 iverilog 编译生成的代码
6. **功能验证**: 运行仿真测试与参考实现对比
7. **结果记录**: 记录编译状态、测试通过情况和详细日志

### 静态过滤器

**背景问题**: 某些模型生成的代码包含组合逻辑环路（如 `assign out = (clk && ~out) ^ in;`），导致仿真无限循环卡死。例如llama3.2：3b的Problem53和155。超时机制无法解决。

**解决方案**: 集成静态分析器检测和过滤危险代码模式：

**检测模式**:
- 组合逻辑环路：信号在 assign 语句中自我引用
- 复杂反馈回路：多信号形成的循环依赖
- 不安全的时钟使用：可能导致竞争条件的时钟模式

**处理流程**:
1. 在编译前对生成的代码进行静态分析
2. 如果检测到危险模式，跳过仿真测试并标记为 "STATIC FAILED"
3. 记录具体的失败原因到日志文件
4. 确保评估框架能够稳定运行，避免因个别问题导致整体测试中断

## 结果文件结构

评估完成后，结果保存在以下位置：

```
results/
├── corrected_test_results.txt     # 汇总报告
├── corrected_test_results.csv      # CSV格式数据
├── corrected_test_results.json     # JSON详细数据
└── [model]_0shot_temp0.0/         # 各模型详细结果
    ├── Prob*_raw_response.txt     # 模型原始响应
    ├── Prob*_extracted_code.txt   # 提取的Verilog代码
    ├── Prob*.sv                   # 完整测试代码文件
    └── Prob*-sv-iv-test.log       # 编译和测试日志
```

## 原始 VerilogEval 项目

本项目基于 VerilogEval 官方数据集，相关工作包括：

- **VerilogEval v1** (2023): "[VerilogEval: Evaluating Large Language Models for Verilog Code Generation](https://arxiv.org/abs/2309.07544)" - ICCAD 2023
- **VerilogEval v2** (2024): "[Revisiting VerilogEval: Newer LLMs, In-Context Learning, and Specification-to-RTL Tasks](https://arxiv.org/abs/2408.11053)" - 增加了规范到RTL转换、上下文学习等功能

**分支说明**:
- `main`: VerilogEval V2 改进版本
- `release/1.0.0`: 原始 VerilogEval 1.0 基准

## 引用

如果使用本评估基准，请引用：

**VerilogEval V2**:
```bibtex
@misc{pinckney2024revisitingverilogevalnewerllms,
      title={Revisiting VerilogEval: Newer LLMs, In-Context Learning, and Specification-to-RTL Tasks},
      author={Nathaniel Pinckney and Christopher Batten and Mingjie Liu and Haoxing Ren and Brucek Khailany},
      year={2024},
      eprint={2408.11053},
      archivePrefix={arXiv},
      primaryClass={cs.SE},
      url={https://arxiv.org/abs/2408.11053},
}
```

**原始 VerilogEval**:
```bibtex
@inproceedings{liu2023verilogeval,
  title={{VerilogEval:} Evaluating Large Language Models for Verilog Code Generation},
  author={Liu, Mingjie and Pinckney, Nathaniel and Khailany, Brucek and Ren, Haoxing},
  booktitle={2023 IEEE/ACM International Conference on Computer-Aided Design (ICCAD)},
  year={2023}
}
```

---

*此文档用于持续记录 VerilogEval Benchmark 的测试结果，后续测试结果请按日期和任务类型添加到对应章节中。*