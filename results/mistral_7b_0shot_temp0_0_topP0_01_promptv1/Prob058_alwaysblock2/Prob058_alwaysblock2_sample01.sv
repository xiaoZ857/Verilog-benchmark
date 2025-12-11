
module TopModule (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);
assign out_assign = a ^ b;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
