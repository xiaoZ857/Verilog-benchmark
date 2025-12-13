
module TopModule (
  input a,
  input b,
  input c,
  output out
);

assign out = (a & ~b & ~c) | (~c & b) | (c & b);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
