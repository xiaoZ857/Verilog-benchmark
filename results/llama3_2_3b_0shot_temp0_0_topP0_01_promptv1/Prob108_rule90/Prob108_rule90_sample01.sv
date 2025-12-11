
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
assign q = {load, q[511:2], q[511:1], q[511:0]} ^ {q[-1:0], q[-1:-2], q[-1:-1]};
endmodule
