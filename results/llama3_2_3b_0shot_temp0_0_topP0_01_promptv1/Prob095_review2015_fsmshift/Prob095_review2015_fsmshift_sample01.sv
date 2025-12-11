
module TopModule (
  input clk,
  input reset,
  output shift_ena
);
assign shift_ena = (reset) ? 1 : ((clk == 4'b1111) && (pattern_detected));

endmodule
