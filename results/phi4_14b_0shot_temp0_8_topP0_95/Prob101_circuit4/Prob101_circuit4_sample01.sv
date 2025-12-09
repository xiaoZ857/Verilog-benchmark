
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

  assign q = (~a & ~d) | (a & (b | c));

endmodule

// VERILOG-EVAL: errant inclusion of module definition
