
module TopModule (
  input clk,
  input j,
  input k,
  output reg Q
);
assign Q = (j & k) ? !Q : Q;

// VERILOG-EVAL: endmodule not found
