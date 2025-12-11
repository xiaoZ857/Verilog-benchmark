
module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
assign s = a + b;
assign overflow = (a[7] == 1'b1) && ((~a + ~b)[7] == 1'b1);
endmodule
