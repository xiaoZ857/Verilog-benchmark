
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
assign state = $unsigned((a & (b | (~a) & (~b))), 8);
always @(posedge clk)
if (!reset)
q <= a ^ b;
else
q <= reset ? 1'b0 : state;

// VERILOG-EVAL: endmodule not found
