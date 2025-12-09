
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
module top_module (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output [7:0] out
);

assign out = (~sel & a) | (sel & b);

// VERILOG-EVAL: endmodule not found
