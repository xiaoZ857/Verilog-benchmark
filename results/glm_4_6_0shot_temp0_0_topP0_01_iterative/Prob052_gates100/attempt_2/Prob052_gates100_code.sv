
module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);
// Implement 100-input AND, OR, and XOR gates using reduction operators
assign out_and = &in;  // Reduction AND of all 100 bits
assign out_or = |in;   // Reduction OR of all 100 bits  
assign out_xor = ^in;  // Reduction XOR of all 100 bits

endmodule
