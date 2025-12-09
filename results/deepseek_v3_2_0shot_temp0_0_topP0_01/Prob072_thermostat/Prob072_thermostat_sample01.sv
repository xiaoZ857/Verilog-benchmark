
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
  // Determine heater and aircon based on mode and temperature signals
  assign heater = mode & too_cold;
  assign aircon = ~mode & too_hot;
  
  // Fan turns on if either heater, aircon, or manual fan request is active
  assign fan = heater | aircon | fan_on;

// VERILOG-EVAL: endmodule not found
