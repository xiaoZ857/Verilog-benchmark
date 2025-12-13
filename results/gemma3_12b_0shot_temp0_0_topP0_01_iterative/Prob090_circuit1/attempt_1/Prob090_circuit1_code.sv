
module TopModule (
  input a,
  input b,
  output q
);

  assign q = (a & b) ? 1 : 0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
