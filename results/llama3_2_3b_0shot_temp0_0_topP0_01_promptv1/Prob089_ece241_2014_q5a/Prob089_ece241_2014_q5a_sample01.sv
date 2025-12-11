
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
assign z = ~x + 1'b1;

always @(posedge clk) begin
    if (areset)
        z <= 1'b0;
    else
        z <= ~x + 1'b1;
endmodule
