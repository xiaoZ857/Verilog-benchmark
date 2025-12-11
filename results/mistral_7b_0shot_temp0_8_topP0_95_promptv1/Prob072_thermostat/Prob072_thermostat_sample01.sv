
module TopModule (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
 ```verilog
always @(posedge clk) begin
    if (mode == 1) begin // Heating mode
        heater <= (too_cold || fan_on);
        aircon <= 1'b0;
        fan <= (heater || fan_on);
    end else begin // Cooling mode
        heater <= 1'b0;
        aircon <= (too_hot || fan_on);
        fan <= (aircon || fan_on);
    end
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
