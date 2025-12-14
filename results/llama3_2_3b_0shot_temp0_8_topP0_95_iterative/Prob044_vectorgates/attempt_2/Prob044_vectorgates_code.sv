
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

assign out_or_bitwise = a | b;
assign out_or_logical = ~a & ~b;
assign out_not[3:2] = ~b[2:1];  // bits [5:4]
assign out_not[1:0] = ~(a[0:0]);

// VERILOG-EVAL: endmodule not found
