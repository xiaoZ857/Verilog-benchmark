
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
  // Add the two numbers
  assign s = a + b;
  
  // Signed overflow occurs when the signs of a and b are the same,
  // and the sign of the result s is different from the sign of a (or b).
  // Specifically, overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7])
  assign overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);

endmodule
