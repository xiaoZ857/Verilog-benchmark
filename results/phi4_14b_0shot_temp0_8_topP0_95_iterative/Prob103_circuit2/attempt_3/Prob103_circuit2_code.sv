
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = a ^ b ^ c ^ d;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
