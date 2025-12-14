
module TopModule (
  input clk,
  input reset,
  output shift_ena
);

// Implement a simple FSM that asserts shift_ena for exactly 4 cycles after reset
reg [1:0] counter;

always @(posedge clk) begin
  if (reset) begin
    // On reset, start the 4-cycle shift enable sequence
    counter <= 2'b00;
    shift_ena <= 1'b1;
  end else begin
    if (counter == 2'b11) begin
      // After 4 cycles (counter reached 3), disable shift_ena
      shift_ena <= 1'b0;
    end else begin
      // Continue counting during the 4-cycle period
      counter <= counter + 1'b1;
    end
  end
end

endmodule
