
module TopModule (
  input clk,
  input reset,
  output reg [31:0] q
);
assign q = (reset) ? 32'h1 : ($eqv(0, q[0]) | $eqv(0, q[22]) | $eqv(0, q[2]) | $eqv(0, q[31]))? 32'h0:q;
endmodule
