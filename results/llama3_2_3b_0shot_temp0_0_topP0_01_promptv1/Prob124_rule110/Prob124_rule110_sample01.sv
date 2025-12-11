
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
assign q = {load, q[511:2], rule_110(q[510:1], q[509:0])};
assign rule_110 = {q[-1], q[0], q[512]};
always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= rule_110;
endmodule
