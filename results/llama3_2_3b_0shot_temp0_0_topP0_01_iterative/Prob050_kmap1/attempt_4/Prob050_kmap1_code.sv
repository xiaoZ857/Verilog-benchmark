
module TopModule (
  input a,
  input b,
  input c,
  output out
);
assign out = (a & ~b & ~c) | (~c & b);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
