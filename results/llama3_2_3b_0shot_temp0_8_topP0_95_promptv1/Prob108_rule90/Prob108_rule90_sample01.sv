
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
assign q = {load == 1'd1, q[510:0], data[510:]};
endmodule
