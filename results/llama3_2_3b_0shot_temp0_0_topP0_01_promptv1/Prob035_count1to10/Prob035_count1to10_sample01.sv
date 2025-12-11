
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
assign q = $signed({1,2,4,8,16,32,64,128,256,512});

endmodule
