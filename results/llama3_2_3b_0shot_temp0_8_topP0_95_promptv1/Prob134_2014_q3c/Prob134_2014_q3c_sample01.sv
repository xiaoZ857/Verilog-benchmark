
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);
assign Y0 = {x & (y[0] == 0) ? "00" : ~(y[0] == 0)};
assign z = ~((x | y)[1]);
endmodule
