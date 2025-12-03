

module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

assign Q = (E & ~L) ? w : Q;
assign Q[0] = (R & ~L) ? w[0] : Q[0];
assign Q[1:0] = (R & ~L) ? w[1:0] : Q[1:0];

// VERILOG-EVAL: endmodule not found
