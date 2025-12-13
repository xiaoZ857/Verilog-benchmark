
module TopModule (
  input a,
  input b,
  input c,
  input d,
  input e,
  output [24:0] out
);
assign out[24] = ~a ^ a;
assign out[23] = ~a ^ b;
assign

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
