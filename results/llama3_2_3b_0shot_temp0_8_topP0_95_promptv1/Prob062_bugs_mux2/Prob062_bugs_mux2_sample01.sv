
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
assign out = (~sel & a)[7:0] | (~sel & b)[7:0]; endmodule

// VERILOG-EVAL: endmodule not found
