
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
always @(posedge clk) begin
  if (mode) begin // Heating mode
    heater_en <= too_cold;
    aircon_en <= 0;
  end else begin // Cooling mode
    heater_en <= 0;
    aircon_en <= too_hot;
  end

  fan_en <= (heater_en || aircon_en) || fan_on; // Fan is on if either heater or air conditioner are on, or user requests it
end

`timescale 1ns / 1ps
assign heater = heater_en;
assign aircon = aircon_en;
assign fan = fan_en;

endmodule
