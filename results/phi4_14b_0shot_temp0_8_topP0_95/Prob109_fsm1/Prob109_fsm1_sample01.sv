
module TopModule (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_B = 2'b01, // State B
        STATE_A = 2'b00  // State A
    } state_t;

    // Declare the current and next state registers
    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset to state B
            current_state <= STATE_B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_B: begin
                if (in == 1'b0) 
                    next_state = STATE_A;
                else
                    next_state = STATE_B; // Stay in B on input '1'
            end
            STATE_A: begin
                if (in == 1'b0) 
                    next_state = STATE_B;
                else
                    next_state = STATE_A; // Stay in A on input '1'
            end
            default: begin
                next_state = STATE_B; // Default to state B for safety
            end
        endcase
    end

    // Output logic based on current state (Moore machine)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            out <= 1'b1; // Reset to output of state B
        end else begin
            case (current_state)
                STATE_B: out <= 1'b1;
                STATE_A: out <= 1'b0;
                default: out <= 1'b1; // Default for safety
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
