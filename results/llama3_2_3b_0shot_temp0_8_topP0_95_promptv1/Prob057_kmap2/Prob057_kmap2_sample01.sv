
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out
);
assign out = (a & c) & ~(b | d);

// VERILOG-EVAL: endmodule not found
