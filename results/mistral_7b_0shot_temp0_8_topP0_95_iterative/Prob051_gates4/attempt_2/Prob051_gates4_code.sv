
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);
include "ieee.v"
AND4 u_andGate (out_and, in[3], in[2], in[1], in[0]);
OR4  u_orGate  (out_or , in[3], in[2], in[1], in[0]);
XOR4 u_xorGate(out_xor, in[3], in[2], in[1], in[0]);

// No clock for internal signals as they are combinational
always @* begin
  // No assignment required since the outputs are connected directly to the gates
end

endmodule
