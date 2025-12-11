
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);
assign pedge[0:7] = ~(in[6:0] == 1'b0) ? (in[7] != 1'b0) : 8'b0;
assign pedge[7] = (in[7] != 1'b0 && in[7:0][6:0] == 1'b0) ? 1'b1 : 1'b0;

// VERILOG-EVAL: endmodule not found
