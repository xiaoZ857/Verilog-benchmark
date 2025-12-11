
module TopModule (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);
assign z = (w[2] == 1 && w[1] == 1) ? 1 : !((w[2] || w[0]) && w[1]);
always @(posedge clk or reset)
    if (!reset)
        z <= (~w[2] & ~w[1] & ~w[0]) | ((~w[2] & ~w[1]) & w[0]) & (w[1] & w[0]) | 
             (~w[1] & w[0]);
endmodule
