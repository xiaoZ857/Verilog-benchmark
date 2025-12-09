
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // heater is on if in heating mode and too cold
  assign heater = mode & too_cold;

  // aircon is on if in cooling mode and too hot
  assign aircon = ~mode & too_hot;

  // fan is on if heater or aircon is on, or if fan_on is asserted
  assign fan = heater | aircon | fan_on;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
