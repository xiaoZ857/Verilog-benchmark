
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
assign q = {data, q[511:2], q[510:0]};
assign q[512] = 'z;
endmodule
