
module TopModule (
  input clk,
  input reset,
  output shift_ena
);
assign shift_ena = (reset == 1) || ((clk && ~(shift_ena)) & (~clk & ~reset));

endmodule
