
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
assign q = (a & ~q) ? 4'b000 : (a | q);

endmodule
