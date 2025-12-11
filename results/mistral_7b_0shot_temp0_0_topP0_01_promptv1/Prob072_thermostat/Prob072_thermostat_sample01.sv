
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
    if (mode == 1) begin
        heater <= too_cold;
        aircon <= 1'b0;
    end else begin
        heater <= 1'b0;
        aircon <= too_hot;
    end
    fan <= fan_on || heater || aircon;
end
endmodule

// VERILOG-EVAL: abnormal backticks count
