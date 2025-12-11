
module TopModule (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);
assign q = d;
always @(posedge clk) begin
    if (areset)
        q <= 1'b0;
    else
        q <= d;
endmodule
