
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
assign out = sel[0] ? a : b;

// VERILOG-EVAL: endmodule not found
