

module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

assign out_and = &in; // Reduction AND for all inputs

assign out_or = |in;   // Reduction OR for all inputs

assign out_xor = ^in;  // Reduction XOR for all inputs

endmodule
