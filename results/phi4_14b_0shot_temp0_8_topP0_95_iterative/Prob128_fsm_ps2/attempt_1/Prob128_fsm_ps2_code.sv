
module TopModule (
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output reg done
);

    // Define states for the FSM
    typedef enum logic [1:0] {
        IDLE,      // Waiting for a new message start byte
        RECEIVE_2, // Received first byte; waiting for second byte
        RECEIVE_3  // Received second byte; waiting for third byte
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            
            // Signal 'done' when transitioning from RECEIVE_3 to IDLE
            if (current_state == RECEIVE_3 && next_state == IDLE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        // Default assignments for next state and outputs
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = RECEIVE_2; // Found a start byte
                end else begin
                    next_state = IDLE;
                end
            end
            
            RECEIVE_2: begin
                next_state = RECEIVE_3; // Move to the third byte after second is received
            end

            RECEIVE_3: begin
                next_state = IDLE; // Reset to IDLE after receiving a full message
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
