
module TopModule (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding for FSM with a wider bit width to accommodate all states
    typedef enum logic [3:0] {  // Changed from [2:0] to [3:0]
        IDLE,      // Wait for start bit
        START_BIT, // Confirm start bit is 0
        RECEIVE_1, // Receive data bits (LSB first)
        RECEIVE_2,
        RECEIVE_3,
        RECEIVE_4,
        RECEIVE_5,
        RECEIVE_6,
        RECEIVE_7,
        RECEIVE_8,
        WAIT_STOP  // Wait for stop bit
    } state_t;

    state_t current_state, next_state;
    
    reg [2:0] bit_counter; // Count data bits received (1 to 8)

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b00000000;
            done <= 1'b0;
            bit_counter <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == WAIT_STOP && in == 1'b1) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end

            if (current_state >= RECEIVE_1 && current_state <= RECEIVE_8) begin
                out_byte[bit_counter] <= in; // Store LSB first
                bit_counter <= bit_counter + 3'd1;
            end else begin
                bit_counter <= 3'b000; // Reset counter when not receiving data bits
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: if (in == 1'b0) begin
                    next_state = START_BIT;
                end
            
            START_BIT: if (in == 1'b1) begin // Confirm start bit high after low transition
                        next_state = RECEIVE_1;
                    end else begin
                        next_state = IDLE; // Invalid start, go back to IDLE
                    end
            
            RECEIVE_1: next_state = RECEIVE_2;
            RECEIVE_2: next_state = RECEIVE_3;
            RECEIVE_3: next_state = RECEIVE_4;
            RECEIVE_4: next_state = RECEIVE_5;
            RECEIVE_5: next_state = RECEIVE_6;
            RECEIVE_6: next_state = RECEIVE_7;
            RECEIVE_7: next_state = RECEIVE_8;
            RECEIVE_8: if (in == 1'b1) begin
                        next_state = WAIT_STOP; // Verify stop bit
                    end else begin
                        next_state = IDLE; // Invalid data, go back to IDLE
                    end

            WAIT_STOP: if (in == 1'b1) begin
                        next_state = IDLE;
                    end 
                    // Stay in WAIT_STOP until a valid stop bit is detected
            
            default: next_state = IDLE; 
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
