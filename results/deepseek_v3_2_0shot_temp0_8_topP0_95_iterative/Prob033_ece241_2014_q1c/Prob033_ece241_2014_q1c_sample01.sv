
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
  // Add the two numbers
  assign s = a + b;
  
  // Determine signed overflow: overflow occurs if both inputs have the same sign
  // and the result has the opposite sign.
  assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule
