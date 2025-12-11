
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
always @(*) begin
    heater = mode & too_cold;
    aircon = ~mode & too_hot;
    fan = fan_on | heater | aircon;
end
endmodule
