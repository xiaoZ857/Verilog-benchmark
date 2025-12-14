
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.
// Assume that you have two 8-bit 2's complement numbers, a[7:0] and b[7:0].
// These numbers are added to produce s[7:0]. Also compute whether a
// (signed) overflow has occurred.

  // Add the two 8-bit numbers
  assign s = a + b;
  
  // Detect signed overflow
  // Overflow occurs when adding two positive numbers gives a negative result
  // or when adding two negative numbers gives a positive result
  assign overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);

endmodule
