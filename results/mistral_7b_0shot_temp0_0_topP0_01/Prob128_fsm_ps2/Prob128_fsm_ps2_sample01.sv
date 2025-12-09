

module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] current_state = {3'b000, 3'b001, 3'b010, 3'b011}; // Initial, Data, and Done states
reg [7:0] data_buffer = 8'b0;
reg done = 0;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= 3'b000; // Reset to initial state
        data_buffer <= 8'b0; // Clear data buffer
        done <= 0; // Clear done signal
    end else begin
        case (current_state)
            3'b000: begin // Initial state
                if (in[3] == 1) begin
                    current_state <= 3'b001; // Transition to Data state
                    data_buffer <= in; // Store the incoming byte
                end
            end,
            3'b001: begin // Data state
                if (in[3] == 1) begin
                    current_state <= 3'b010; // Transition to Done state
                end else begin
                    data_buffer <= {data_buffer[7:0], in}; // Shift the buffer and store the incoming byte
                end
            end,
            3'b010: begin // Done state
                if (in[3] == 1) begin // Check if the next byte is part of another message
                    current_state <= 3'b011; // Transition to Idle state
                    data_buffer <= {data_buffer[7:0], in}; // Store the incoming byte for the next message
                end else begin
                    done <= 1; // Signal that a message has been received and done is high
                    current_state <= 3'b000; // Transition back to Initial state
                end
            end,
            3'b011: begin // Idle state
                data_buffer <= {data_buffer[7:0], in}; // Store the incoming byte for the next message
            end
        endcase
    end
end

assign done = done || (current_state == 3'b011); // Assign done to the value of done or Idle state

endmodule
