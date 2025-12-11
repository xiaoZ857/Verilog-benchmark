
module TopModule (
  input clk,
  input a,
  output reg q
);
assign q = (a == 1'b1) ? 1 : reset && (q == 1);

endmodule
