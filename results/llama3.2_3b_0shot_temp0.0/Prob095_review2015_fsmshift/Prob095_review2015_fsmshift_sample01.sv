

module TopModule (
  input clk,
  input reset,
  output shift_ena
);

assign shift_ena = !reset && clk;

// VERILOG-EVAL: endmodule not found
