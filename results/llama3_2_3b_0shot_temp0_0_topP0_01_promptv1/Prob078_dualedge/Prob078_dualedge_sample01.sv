
module TopModule (
  input clk,
  input d,
  output reg q
);
assign q = d & ~q | (clk & q);

endmodule
