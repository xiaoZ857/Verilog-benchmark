
module TopModule (
  input logic mode,
  input logic too_cold,
  input logic too_hot,
  input logic fan_on,
  output logic heater,
  output logic aircon,
  output logic fan
);

always @(posedge clk) begin
  if (mode == 1) begin // Heating mode
    if (too_cold) begin
      heater <= 1'b1;
      aircon <= 1'b0;
    end else begin
      heater <= 1'b0;
    end
  end else begin // Cooling mode
    if (too_hot) begin
      heater <= 1'b0;
      aircon <= 1'b1;
    end else begin
      heater <= 1'b0;
    end
  end

  if ((heater || aircon) || fan_on) begin // Turn on the fan when heater, aircon or user request is on
    fan <= 1'b1;
  end else begin
    fan <= 1'b0;
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
