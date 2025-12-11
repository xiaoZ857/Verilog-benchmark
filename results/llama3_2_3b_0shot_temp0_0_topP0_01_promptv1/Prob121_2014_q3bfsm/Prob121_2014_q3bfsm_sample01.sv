
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);
assign z = (reset) ? 1'b0 : ((x == 1) ? 1'b1 : (y[2:0] == 3'b001 || y[2:0] == 3'b011));

// VERILOG-EVAL: endmodule not found
