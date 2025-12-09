
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output reg heater,
  output reg aircon,
  output reg fan
);

  always @(*) begin
    // Default to off state
    heater = 0;
    aircon = 0;
    fan = 0;

    // Determine the operation based on mode and temperature
    if (mode == 1) begin // Heating Mode
      if (too_cold) begin
        heater = 1;      // Turn on the heater
        fan = 1;         // Turn on the fan to circulate air
      end
    end else begin // Cooling Mode
      if (too_hot) begin
        aircon = 1;      // Turn on the air conditioner
        fan = 1;         // Turn on the fan to circulate air
      end
    end

    // Allow user to turn on the fan independently
    if (fan_on) begin
      fan = 1;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
