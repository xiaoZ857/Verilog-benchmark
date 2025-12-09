
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
  // Add the two numbers
  assign s = a + b;
  
  // Signed overflow occurs when adding two numbers with the same sign
  // and the result has the opposite sign
  assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
