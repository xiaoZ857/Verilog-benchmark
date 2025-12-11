
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);
assign Y0 = (y[2] == 0) ? y[1] : (y[2] == 1 && y[0] == 0) ? y[1] : (y[2] == 1 && y[0] == 1) ? y[1] : 0;
assign z = (x == 0 && y[2] == 0 && y[1] == 0 && y[0] == 0) || (x == 1 && y[2] == 1 && y[1] == 0 && y[0] == 0) || (x == 0 && y[2] == 0 && y[1] == 1 && y[0] == 0) || (x == 1 && y[2] == 1 && y[1] == 1 && y[0] == 0);

// VERILOG-EVAL: endmodule not found
