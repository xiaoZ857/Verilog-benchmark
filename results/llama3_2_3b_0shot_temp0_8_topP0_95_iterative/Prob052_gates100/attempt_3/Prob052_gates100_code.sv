
module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);
begin

    // Calculate the AND result
    out_and = ~in[99:1];  // calculate AND for all but last bit separately
    
    // Calculate the OR result
    out_or = in;

    // Calculate the XOR result
    out_xor = ~(in & (~in))[0]; // XOR will always be 1 if any input is 1

endmodule
