
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
// Thermostat Module
module Thermostat(
  // Inputs
  input mode,  // Mode: heating (1) or cooling (0)
  input too_cold, // Too cold threshold
  input too_hot, // Too hot threshold
  input fan_on,  // Fan on request

  // Outputs
  output heater,  // Heater on/off
  output aircon, // Air conditioner on/off
  output fan       // Blower fan on/off
);

// Internal state
reg [1:0] mode_state; // Mode is stored in this reg

// Initialize the internal state with the desired mode
initial begin
  if (mode == 1) mode_state = 2'b10; // Heating mode
  else mode_state = 2'b00; // Cooling mode
end

// Heater and air conditioner logic
always @(posedge clk or negedge reset_n) begin
  case (mode)
    1: // Heating mode
      if (too_cold && !heater) heater <= 1;
      else heater <= 0;
      heater <= fan_on ? 1 : 0;

    0: // Cooling mode
      if (too_hot && !aircon) aircon <= 1;
      else aircon <= 0;
      aircon <= fan_on ? 1 : 0;
  endcase
end

// Fan logic
always @(posedge clk or negedge reset_n) begin
  case (mode)
    1: // Heating mode
      fan <= heater;

    0: // Cooling mode
      fan <= !aircon; // Turn on if aircon is off
  endcase
end

// Output signals
assign heater = heater;
assign aircon = aircon;
assign fan = fan;

// You might need to add a reset statement or a clock domain declaration,
// depending on your specific use case.
endmodule
