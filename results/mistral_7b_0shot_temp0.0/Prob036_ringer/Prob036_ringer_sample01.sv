

module TopModule (
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);

always @(posedge clk) begin
    if (ring && !vibrate_mode)
        ringer <= 1'b1;
    else if (vibrate_mode)
        motor <= 1'b1;
    else
        ringer <= 1'b0;
    motor <= 1'b0;
end

// VERILOG-EVAL: endmodule not found
