
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out
);
  assign out = (a & c) | (b & d) | (a & b & c) | (c & d);

// VERILOG-EVAL: endmodule not found
