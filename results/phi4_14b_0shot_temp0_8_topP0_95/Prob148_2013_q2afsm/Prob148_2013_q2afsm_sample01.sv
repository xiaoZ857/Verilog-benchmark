
module TopModule (
    input wire clk,
    input wire resetn,
    input wire [3:1] r, // Inputs from devices; only r[1], r[2], and r[3] are used.
    output reg [3:1] g  // Outputs to grant access to the resource
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_t;

    state_t current_state, next_state;

    // Always block for state transition logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;  // Synchronous reset to STATE_A
        else
            current_state <= next_state;
    end

    // Next state logic based on the current state and input requests
    always_comb begin
        case (current_state)
            STATE_A: begin
                if (r[1])
                    next_state = STATE_B;  // Priority to device 1
                else if (r[2])
                    next_state = STATE_C;  // Next priority to device 2
                else if (!r[1] && !r[2] && !r[3])
                    next_state = STATE_D;  // Stay in A, but transition internally for r3 check
                else
                    next_state = STATE_A;
            end

            STATE_B: begin
                if (r[1])
                    next_state = STATE_B;  // Maintain state B as long as device 1 requests
                else
                    next_state = STATE_A;  // Go back to A when no longer requested
            end

            STATE_C: begin
                if (r[2])
                    next_state = STATE_C;  // Maintain state C as long as device 2 requests
                else
                    next_state = STATE_A;  // Go back to A when no longer requested
            end

            STATE_D: begin
                if (!r[1] && !r[2] && r[3])
                    next_state = STATE_B;  // Grant access to device 3 only if it's the only request
                else
                    next_state = STATE_A;  // Return to A otherwise
            end

            default: begin
                next_state = STATE_A;
            end
        endcase
    end

    // Output logic for granting access based on state
    always_comb begin
        g[1] = (current_state == STATE_B); // Grant device 1 in state B
        g[2] = (current_state == STATE_C); // Grant device 2 in state C
        g[3] = 0;                         // Device 3 is handled through internal transition to B

        if (next_state == STATE_B && current_state == STATE_D && !r[1] && !r[2] && r[3]) begin
            // Transition to B directly from D, grant device 3
            g[3] = 1;
        end else begin
            g[3] = 0; // Default no grant for device 3 unless specific condition met
        end

    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
