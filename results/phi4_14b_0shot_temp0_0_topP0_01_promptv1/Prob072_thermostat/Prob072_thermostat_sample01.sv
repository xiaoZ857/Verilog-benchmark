
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
assign heater = (mode == 1) && too_cold;
assign aircon = (mode == 0) && too_hot;

always @(*) begin
    fan = ((heater || aircon) || fan_on);
end

endmodule
