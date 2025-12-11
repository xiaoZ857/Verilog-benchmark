
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);
assign out = $signed(in[31:0]);
endmodule
