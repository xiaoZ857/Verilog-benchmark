

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
  if (mode == 1) begin // Heating mode
    heater <= too_cold;
    aircon <= 0;
  end else begin // Cooling mode
    heater <= 0;
    aircon <= too_hot;
  end

  fan <= heater | aircon | fan_on;

endmodule
