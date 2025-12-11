
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
  assign s = a + b;
  
  wire sign_a = a[7];
  wire sign_b = b[7];
  wire sign_s = s[7];
  
  assign overflow = (sign_a == sign_b) && (sign_s != sign_a);
  
endmodule
