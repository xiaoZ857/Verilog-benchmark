
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
assign out_or_logical_tmp = a | b;
assign out_or_logical = out_or_logical_tmp;

reg [5:0] inv_a;
reg [2:0] inv_b;

// Inverse (NOT) of both vectors using registers
assign inv_b[2:0] = ~b;
assign inv_a[5:3] = ~a;
assign inv_a[2:0] = ~a; // Re-assigning lower half of out_not with the inverse of a

assign out_not = {inv_a, inv_b}; // Concatenate upper and lower halves to form full out_not

endmodule
