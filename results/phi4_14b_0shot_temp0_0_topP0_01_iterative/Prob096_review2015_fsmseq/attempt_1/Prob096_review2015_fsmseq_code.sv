
module TopModule (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,   // Initial state, waiting for sequence
        S1 = 3'b001,     // Detected '1'
        S11 = 3'b010,    // Detected '11'
        S110 = 3'b011,   // Detected '110'
        FOUND = 3'b100   // Sequence '1101' found
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            start_shifting <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == FOUND) begin
                start_shifting <= 1; // Maintain start_shifting as 1 once sequence is found
            end
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = S1;
                end else begin
                    next_state = IDLE;
                end
            end

            S1: begin
                if (data == 1'b1) begin
                    next_state = S11;
                end else begin
                    next_state = IDLE; // Reset to IDLE on '0'
                end
            end

            S11: begin
                if (data == 1'b0) begin
                    next_state = S110;
                end else begin
                    next_state = S11; // Stay in S11 on another '1'
                end
            end

            S110: begin
                if (data == 1'b1) begin
                    next_state = FOUND;
                end else begin
                    next_state = IDLE; // Reset to IDLE on '0'
                end
            end

            FOUND: begin
                next_state = FOUND; // Remain in FOUND state until reset
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
