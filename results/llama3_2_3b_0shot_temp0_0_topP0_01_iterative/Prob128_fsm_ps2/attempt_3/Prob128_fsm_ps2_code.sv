
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
reg [2:0] state;
reg [7:0] message_in;
wire [7:0] out;

reg [3:0] done_state; // New variable to track the state of the done signal

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // Reset to idle state
        message_in <= 8'b0; // Clear message buffer
        done_state <= 4'b0000; // Reset done state
    end else begin
        if (message_in[3] == 1) begin // Check for start of message
            state <= 3'b001; // Start of message detected
            done_state <= 4'b0000; // Reset done state
        end else if (state != 3'b000) begin // Discard bytes until start of message is found
            message_in <= in[2:0]; // Update message buffer with new byte
        end else begin // Invalid message, reset to idle state
            state <= 3'b000;
            done_state <= 4'b0000;
        end

        if (message_in[3] == 1 && message_in[2:0] != 8'b0) begin // Check for second byte of message
            state <= 3'b010; // Second byte received, waiting for third byte
            done_state <= 4'b0000; // Reset done state
        end else if (state == 3'b001 && message_in[2:0] != 8'b0) begin // Check for third byte of message
            state <= 3'b011; // Third byte received, signal done
            done_state <= 4'b1111; // Signal done
        end else if (message_in[3] == 1 && message_in[2:0] == 8'b0) begin // Check for start of message with no data
            state <= 3'b001;
            done_state <= 4'b0000;
        end else begin // Invalid message, reset to idle state
            state <= 3'b000;
            done_state <= 4'b0000;
        end

        if (done_state == 4'b1111) begin // Done state
            done <= 1'b1;
            state <= 3'b000; // Reset to idle state after done signal is sent
            done_state <= 4'b0000; // Reset done state
        else begin
            done <= 1'b0;
        end
    end
endmodule
