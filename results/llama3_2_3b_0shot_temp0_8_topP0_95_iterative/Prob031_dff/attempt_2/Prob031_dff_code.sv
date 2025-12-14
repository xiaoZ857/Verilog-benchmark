
module TopModule (
  input clk,
  input d,
  output reg q
);
module DFF (
  input clk,
  input d,
  output reg q
);

TopModule top_module (
  .clk(clk),
  .d(d),
  .q(q)
);

endmodule
