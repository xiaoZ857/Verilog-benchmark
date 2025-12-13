
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

  // Add two 8-bit 2's complement numbers
  assign s = a + b;
  
  // Detect signed overflow
  // Overflow occurs when:
  // 1. Adding two positive numbers results in a negative number
  // 2. Adding two negative numbers results in a positive number
  assign overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);

endmodule
