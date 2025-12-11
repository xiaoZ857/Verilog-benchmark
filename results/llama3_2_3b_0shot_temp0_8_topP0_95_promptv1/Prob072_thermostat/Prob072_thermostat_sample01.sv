
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
assign heater = !mode ? (fan_on || to_cold) : !(fan_on && too_cold);
assign aircon = !mode & to_hot;
assign fan = mode;

always @(posedge clk)
begin
    heater <= !mode ? (fan_on || to_cold) : !(fan_on && to_cold);
    aircon <= !mode & to_hot;
    fan <= mode;
end

// VERILOG-EVAL: endmodule not found
