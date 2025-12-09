
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  // Compute the AND of all inputs
  assign out_and = &in; // The `&` operator computes the bitwise reduction AND

  // Compute the OR of all inputs
  assign out_or = |in;  // The `|` operator computes the bitwise reduction OR

  // Compute the XOR of all inputs
  assign out_xor = ^in; // The `^` operator computes the bitwise reduction XOR

endmodule

// VERILOG-EVAL: errant inclusion of module definition
