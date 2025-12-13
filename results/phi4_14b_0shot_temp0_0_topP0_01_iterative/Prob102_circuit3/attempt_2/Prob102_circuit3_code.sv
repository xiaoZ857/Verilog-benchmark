
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

  assign q = (a ? ((!b & d) | (b & (c | d))) : (b & d));

endmodule

// VERILOG-EVAL: errant inclusion of module definition
