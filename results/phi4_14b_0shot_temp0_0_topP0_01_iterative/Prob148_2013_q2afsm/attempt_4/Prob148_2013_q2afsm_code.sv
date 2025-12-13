
module TopModule (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011
    } state_t;

    state_t current_state, next_state;

    // Always block for state transitions with synchronous reset
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A; // Synchronous reset to state A
        else
            current_state <= next_state;
    end

    // Always block for determining the next state
    always_comb begin
        case (current_state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (!r[1] && !r[2] && r[3]) // Corrected condition for state D
                    next_state = D;
                else
                    next_state = A;
            end

            B: begin
                if (r[1])
                    next_state = B; // Stay in B if r1 is still 1
                else
                    next_state = A; // Go back to A if r1 becomes 0
            end

            C: begin
                if (r[2])
                    next_state = C; // Stay in C if r2 is still 1
                else
                    next_state = A; // Go back to A if r2 becomes 0
            end

            D: begin
                if (r[1]) // Corrected condition for state B
                    next_state = B; // Priority to r1
                else if (r[2])
                    next_state = C; // Then check r2
                else
                    next_state = A;
            end

            default: next_state = A;
        endcase
    end

    // Always block for output logic
    always_comb begin
        g = 3'b000; // Default all grants to 0

        case (current_state)
            B: g[1] = 1; // Grant to device 1
            C: g[2] = 1; // Grant to device 2
            D: g[3] = 1; // Grant to device 3
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
