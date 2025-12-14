
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
output [2:0] out_or_bitwise;
output out_or_logical;
output [5:0] out_not;

assign out_or_bitwise = a | b; // Compute bitwise OR of vectors a and b
assign out_or_logical = ~a & ~b; // Compute logical OR of vectors a and b
assign out_not[3:2] = ~(b[1:0]);  // Compute inverse (NOT) of bits [5:4] of vector b
assign out_not[4:3] = ~(b[2:1]);  // Compute inverse (NOT) of bits [4:3] of vector b
assign out_not[2:1] = ~(a[0:0]); // Compute inverse (NOT) of bit [0] of vector a
assign out_not[0:0] = ~(a[1:0]);  // Compute inverse (NOT) of bits [1:0] of vector a

endmodule
