
module TopModule (
  input a,
  input b,
  output out
);

  // Implement NOR gate functionality
  assign out = ~(a | b);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
