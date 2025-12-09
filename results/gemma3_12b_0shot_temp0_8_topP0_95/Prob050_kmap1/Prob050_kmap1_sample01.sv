
module TopModule (
  input a,
  input b,
  input c,
  output out
);

  assign out = (a & b) | (a & c) | (b & c);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
