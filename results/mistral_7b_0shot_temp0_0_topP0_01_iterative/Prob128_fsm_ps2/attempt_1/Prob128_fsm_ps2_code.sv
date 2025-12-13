
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state; // FSM states: IDLE, WAIT_FOR_START, RECEIVE
reg [7:0] buffer; // Buffer to store received bytes
reg done;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b000; // Reset FSM to IDLE state
        done <= 0;
        buffer <= 8'b0000_0000;
    end else begin
        case(state)
            2'b000: begin // IDLE state
                if (in[3] == 1) begin
                    state <= 2'b001; // Transition to WAIT_FOR_START state
                    buffer <= in;
                end
            end,
            2'b001: begin // WAIT_FOR_START state
                if (in[3] == 1) begin
                    state <= 2'b010; // Transition to RECEIVE state
                    buffer <= in;
                end
            end,
            2'b010: begin // RECEIVE state
                if (in[3] == 0) begin
                    state <= 2'b000; // Transition back to IDLE state
                end else if ((buffer[7:4] == 8'b0101010) && (in[3] == 1)) begin
                    state <= 2'b011; // Wait for the third byte
                    buffer <= {buffer, in};
                end
            end,
            2'b011: begin // Wait for the third byte
                if ((buffer[7:4] == 8'b0101010) && (in[3] == 1)) begin
                    state <= 2'b000; // Transition back to IDLE state
                    done <= 1; // Signal done in the cycle immediately after the third byte of each message was successfully received
                end
            end
        endcase
    end
end

// Add a reset synchronizer if needed
always @(posedge clk) begin
    if (reset) begin
        q_reset <= 1'b1;
    end else begin
        q_reset <= q_reset[0];
    end
end

assign reset = q_reset; // Use the synchronizer for reset input

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
