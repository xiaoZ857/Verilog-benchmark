
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
assign out = $signed(reset) ? 1'b0 : ($signed(j) == 1'b1 && $signed(k) == 1'b0) ? 1'b1 : 1'b0;

// VERILOG-EVAL: endmodule not found
