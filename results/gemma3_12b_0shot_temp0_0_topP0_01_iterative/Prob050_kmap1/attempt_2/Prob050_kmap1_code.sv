
module TopModule (
  input a,
  input b,
  input c,
  output out
);
  assign out = (a & b) | (a & c) | (b & c);

// VERILOG-EVAL: endmodule not found
