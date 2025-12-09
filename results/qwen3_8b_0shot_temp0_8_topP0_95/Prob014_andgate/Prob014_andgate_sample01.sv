
module TopModule (
  input a,
  input b,
  output out
);

  // Continuous assignment for the AND gate
  assign out = a & b;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
