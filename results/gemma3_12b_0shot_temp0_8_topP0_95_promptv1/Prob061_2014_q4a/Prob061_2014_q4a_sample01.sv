
module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
assign Q = E ? w : (L ? R : Q);
endmodule
