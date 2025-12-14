
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
always @(posedge clk or negedge fan_on) begin
  if (fan_on)
    fan <= 1'b1; // Fan is controlled directly by user request
  else if (mode == 1 && too_cold) // Heating mode, turn on heater when it's too cold
    heater <= 1'b1;
  else if (mode == 0 && too_hot) // Cooling mode, turn on aircon when it's too hot
    aircon <= 1'b1;

  if ((heater == 1'b1 || aircon == 1'b1) || fan_on)
    fan <= 1'b1; // Fan is always turned on when heater, aircon or user request are active
  else
    fan <= 1'b0;
end

// timescale directive should be outside the module definition
`timescale 1ns / 1ps

// VERILOG-EVAL: endmodule not found
