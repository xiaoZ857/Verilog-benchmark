
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
assign q = $signed({1'b0, 1'b1, 2'b11, 3'b111, 4'b1111, 5'b11111, 6'b111111, 7'b1111111, 8'b11111111, 9'b111111111});

endmodule
