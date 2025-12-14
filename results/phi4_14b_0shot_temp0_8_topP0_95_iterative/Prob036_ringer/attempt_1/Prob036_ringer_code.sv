
module TopModule (
  input wire ring,
  input wire vibrate_mode,
  output reg ringer,
  output reg motor
);

always @(*) begin
    if (ring) begin
        if (vibrate_mode) begin
            // If the phone is in vibrate mode, turn on the motor.
            motor = 1;
            ringer = 0;
        end else begin
            // Otherwise, turn on the ringer.
            ringer = 1;
            motor = 0;
        end
    end else begin
        // When not ringing, both outputs should be off.
        ringer = 0;
        motor = 0;
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
