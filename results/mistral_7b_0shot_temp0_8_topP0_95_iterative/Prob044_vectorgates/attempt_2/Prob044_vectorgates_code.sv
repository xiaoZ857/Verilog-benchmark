
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
// Bitwise OR of a and b
wire [2:0] bitwise_OR;
assign bitwise_OR = a | b;
assign out_or_bitwise = bitwise_OR;

// Logical OR of a and b
wire out_or_logical_tmp;
assign out_or_logical_tmp = a | b;
assign out_or_logical = out_or_logical_tmp;

// Inverse (NOT) of both vectors
reg [5:0] out_not_temp;

assign out_not_temp[2:0] = ~a;
assign out_not_temp[5:3] = ~b;
assign out_not = out_not_temp;

endmodule
