

module TopModule (
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);

  always @(posedge clk) begin
    if (vibrate_mode) begin
      motor <= 1;
      ringer <= 0;
    end else begin
      ringer <= ring;
      motor <= 0;
    end
  end

endmodule
