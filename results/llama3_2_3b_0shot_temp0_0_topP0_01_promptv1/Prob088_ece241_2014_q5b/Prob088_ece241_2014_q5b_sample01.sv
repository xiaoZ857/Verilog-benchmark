
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
assign z = ~((x & ~a) | (~x & a));

endmodule
