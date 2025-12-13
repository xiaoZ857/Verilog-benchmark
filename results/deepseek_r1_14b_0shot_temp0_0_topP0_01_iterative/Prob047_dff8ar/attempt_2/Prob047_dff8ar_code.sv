
module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);
The previous code used a synchronous reset because it only checked `areset` inside an

// VERILOG-EVAL: endmodule not found
