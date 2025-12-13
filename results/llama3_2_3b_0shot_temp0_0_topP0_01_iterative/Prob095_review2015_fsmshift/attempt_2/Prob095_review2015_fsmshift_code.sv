
module TopModule (
  input clk,
  input reset,
  output shift_ena
);
reg [1:0] state;
reg [3:0] counter;
reg shift_ena;

// Initialize internal signals on reset
always @(reset) begin
    state <= 2'b00; // Reset to initial state
    counter <= 4'd0; // Reset counter to 0
    shift_ena <= 1'b0; // Reset shift_ena to 0
end

// State machine logic
always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        counter <= 4'd0;
        shift_ena <= 1'b0;
    end else if (state == 2'b01 && counter < 4'd3) begin
        state <= 2'b10; // Move to next state
        counter <= counter + 1;
        shift_ena <= 1'b1; // Enable shift register for 4 clock cycles
    end else if (state == 2'b10 && counter == 4'd3) begin
        state <= 2'b00; // Reset state machine
        counter <= 4'd0;
        shift_ena <= 1'b1; // Enable shift register for 4 clock cycles
    end else if (state != 2'b01) begin
        state <= 2'b00; // Stay in reset state
        counter <= 4'd0;
        shift_ena <= 1'b0; // Disable shift register
    end
end

// Output logic
always @(posedge clk) begin
    if (!reset && (state == 2'b01 || state == 2'b10)) {
        shift_ena <= 1'b1;
    } else {
        shift_ena <= 1'b0;
    }
end

// VERILOG-EVAL: endmodule not found
