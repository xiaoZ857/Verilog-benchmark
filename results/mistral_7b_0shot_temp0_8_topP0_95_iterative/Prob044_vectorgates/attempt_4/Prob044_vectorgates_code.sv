
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
// Logical OR of a and b
wire out_or_logical_tmp;
assign out_or_logical_tmp = a | b;
assign out_or_logical = out_or_logical_tmp;

// Inverse (NOT) of both vectors using registers
reg [5:0] out_not_temp;

// Place inverse of signal 'b' in the upper half of out_not
assign out_not_temp[2:0] = ~b;
assign out_not_temp[5:3] = ~a;
assign out_not = out_not_temp;

// VERILOG-EVAL: endmodule not found
