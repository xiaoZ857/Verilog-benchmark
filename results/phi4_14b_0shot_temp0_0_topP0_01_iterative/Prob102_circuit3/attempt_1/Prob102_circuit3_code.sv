
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

  assign q = b | (~b & d);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
