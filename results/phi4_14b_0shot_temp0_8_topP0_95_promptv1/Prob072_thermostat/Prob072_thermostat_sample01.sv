
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
assign fan = (mode && too_cold) || (!mode && too_hot) || fan_on;

always @(*) begin
    heater = mode && too_cold;
end

always @(*) begin
    aircon = !mode && too_hot;
end
endmodule
