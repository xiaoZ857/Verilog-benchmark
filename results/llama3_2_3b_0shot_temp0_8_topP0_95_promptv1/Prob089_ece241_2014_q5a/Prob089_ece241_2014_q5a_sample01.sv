
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
assign z = ~x + 1;

always @(posedge clk or negedge areset) begin
    if (areset)
        z <= 1'b0;
    else
        z <= ~(x << $clog2({$size_var(x), 1}));
endmodule
