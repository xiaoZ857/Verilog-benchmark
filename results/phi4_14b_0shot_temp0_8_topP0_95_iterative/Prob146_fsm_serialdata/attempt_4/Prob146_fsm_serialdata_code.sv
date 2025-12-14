
module TopModule (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        out_byte <= 8'b00000000;
        done <= 1'b0;
        bit_counter <= 3'b000;
    end else begin
        // Transition to the next state
        current_state <= next_state;

        // Handle data and done signal only within valid states
        if (current_state == WAIT_STOP && in == 1'b1) begin
            done <= 1'b1; // Assert done when a valid stop bit is detected
        end else begin
            done <= 1'b0; // Deassert done otherwise
        end

        // Store incoming data bits into out_byte if in RECEIVE states
        if (current_state >= RECEIVE_1 && current_state < WAIT_STOP) begin
            out_byte[bit_counter] <= in; // Store LSB first, as per specification
            bit_counter <= bit_counter + 3'd1;
        end else begin
            bit_counter <= 3'b000; // Reset counter when not receiving data bits
        end
    end
end

always_comb begin
    next_state = current_state; // Default to holding the current state

    case (current_state)
        IDLE: 
            if (in == 1'b0) begin
                next_state = START_BIT;
            end
        
        START_BIT: 
            if (in == 1'b1) begin
                next_state = RECEIVE_1; // Valid start bit detected, move to receiving data bits
            end else begin
                next_state = IDLE; // Invalid start, return to IDLE state to wait for a new byte
            end

        RECEIVE_1: next_state = RECEIVE_2;
        RECEIVE_2: next_state = RECEIVE_3;
        RECEIVE_3: next_state = RECEIVE_4;
        RECEIVE_4: next_state = RECEIVE_5;
        RECEIVE_5: next_state = RECEIVE_6;
        RECEIVE_6: next_state = RECEIVE_7;
        RECEIVE_7: next_state = RECEIVE_8;

        RECEIVE_8:
            if (in == 1'b1) begin
                next_state = WAIT_STOP; // Verify stop bit after receiving data bits
            end else begin
                next_state = IDLE; // Invalid stop, consider the byte invalid and start over
            end

        WAIT_STOP: 
            if (in == 1'b1) begin
                next_state = IDLE; // Valid byte received, return to IDLE for new bytes
            end
        
        default: 
            next_state = IDLE;
    endcase
end

endmodule
