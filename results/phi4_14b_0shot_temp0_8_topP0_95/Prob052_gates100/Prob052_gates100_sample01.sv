
module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  // Calculate the AND of all inputs
  assign out_and = &in;

  // Calculate the OR of all inputs
  assign out_or = |in;

  // Calculate the XOR of all inputs
  assign out_xor = ^in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
