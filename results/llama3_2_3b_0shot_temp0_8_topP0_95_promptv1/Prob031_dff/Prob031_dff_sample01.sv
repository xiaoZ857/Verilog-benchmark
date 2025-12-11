
module TopModule (
  input clk,
  input d,
  output reg q
);
always @(posedge clk) begin
    if (d)
        q <= 1'b1;
    else
        q <= 1'b0;
endmodule
