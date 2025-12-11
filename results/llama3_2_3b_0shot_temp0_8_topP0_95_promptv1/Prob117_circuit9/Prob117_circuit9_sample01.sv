
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
assign q[2:] = a;
always @(posedge clk) begin
    if (a)
        q <= 4;
    else
        q <= 0;
endmodule
