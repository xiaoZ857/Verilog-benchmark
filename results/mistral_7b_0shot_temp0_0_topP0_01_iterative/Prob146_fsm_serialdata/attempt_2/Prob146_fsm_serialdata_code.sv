
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
reg state; // Current state of the FSM
reg data_bits [7:0]; // Buffer for storing received data bits
reg start_bit = 1'b0; // Flag to check if a start bit has been received
reg stop_bit = 1'b0; // Flag to check if a stop bit has been received
reg is_idle = 1'b1; // Flag to check if the line is idle (high)
reg next_state; // Temporary variable for next state calculation

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        start_bit <= 1'b0;
        stop_bit <= 1'b0;
        out_byte <= 8'bx; // Initialize output byte to unknown value
        done <= 1'b0;
    end else if (state == IDLE && in == 1'b0) begin // Start bit received
        start_bit <= 1'b1;
        next_state <= START;
    end else if (next_state == START) begin // Data bits received
        data_bits[7 - state] <= in;
        state <= next_state + 1;
        if (state == 8) begin // All data bits received
            next_state <= DATA;
        end
    end else if (next_state == DATA && in == 1'b1) begin // Stop bit received
        stop_bit <= 1'b1;
        next_state <= STOP;
    end else if (next_state != IDLE && in == 1'b0) begin // Idle state detected during data reception
        next_state <= IDLE;
    end
    state <= next_state; // Assign the calculated next state to current state
end

always @(posedge clk) begin
    is_idle <= in;
end

assign done = stop_bit; // Output done when stop bit is received
assign out_byte = data_bits[7:0]; // Output the received data byte

// Add any missing Verilog directives or constraints as needed

endmodule
