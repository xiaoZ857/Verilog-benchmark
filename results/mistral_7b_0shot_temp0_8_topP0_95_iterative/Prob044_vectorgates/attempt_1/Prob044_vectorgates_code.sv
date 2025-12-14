
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output reg [5:0] out_not
);

// Bitwise OR of a and b
wire [2:0] bitwise_OR = a | b;
assign out_or_bitwise = bitwise_OR;

// Logical OR of a and b
wire out_or_logical_tmp = a | b;
assign out_or_logical = out_or_logical_tmp;

// Inverse (NOT) of both vectors
assign out_not[2:0] = ~a;
assign out_not[5:3] = ~b;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
