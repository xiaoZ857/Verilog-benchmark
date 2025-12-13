
module TopModule (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE,       // Waiting for the first byte of a message
        RECEIVE_2,  // Received first byte; waiting for second byte
        RECEIVE_3   // Received second byte; waiting for third byte
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            // Only set 'done' in the cycle after receiving the third byte
            if (current_state == RECEIVE_3 && next_state == IDLE)
                done <= 1'b1;
            else
                done <= 1'b0;
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                // Transition to RECEIVE_2 when in[3] is set
                if (in[3]) begin
                    next_state = RECEIVE_2;
                end else begin
                    next_state = IDLE;
                end
            end

            RECEIVE_2: begin
                // Always transition to RECEIVE_3 for the next byte
                next_state = RECEIVE_3;
            end

            RECEIVE_3: begin
                // Transition back to IDLE after receiving third byte
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;  // Default case, should not occur
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
