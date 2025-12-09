
module TopModule (
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);

  // If vibrate mode is enabled, turn on the motor and disable the ringer
  // Otherwise, turn on the ringer and disable the motor.
  always_comb begin
    if (vibrate_mode) begin
      ringer = 0;
      motor = 1;
    end else begin
      ringer = 1;
      motor = 0;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
