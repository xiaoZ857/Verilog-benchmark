
module TopModule (
  input logic mode,
  input logic too_cold,
  input logic too_hot,
  input logic fan_on,
  output logic heater,
  output logic aircon,
  output logic fan
);

reg heater_en, aircon_en, fan_en; // Enable signals for heater, air conditioner, and fan

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

assign heater = heater_en;
assign aircon = aircon_en;
assign fan = fan_en;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
