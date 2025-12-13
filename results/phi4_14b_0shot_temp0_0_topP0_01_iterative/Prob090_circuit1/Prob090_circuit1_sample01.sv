
module TopModule (
  input a,
  input b,
  output q
);

  assign q = a & b;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
