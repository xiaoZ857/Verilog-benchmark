
module TopModule (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,  // Reset state
        B = 2'b01   // Check state
    } state_t;

    state_t current_state, next_state;
    integer count_w_ones;  // Counter for occurrences of w = 1

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            z <= 0;
            count_w_ones <= 0;
        end else begin
            current_state <= next_state;

            // Reset counter and output when transitioning to state B
            if (current_state == A && next_state == B) begin
                count_w_ones <= 0;
                z <= 0;
            end

            // Count occurrences of w = 1 in state B
            if (current_state == B) begin
                if (w) begin
                    count_w_ones <= count_w_ones + 1;
                end

                // After three clock cycles, determine the value of z
                if (count_w_ones == 2) begin
                    z <= 1;
                end else begin
                    z <= 0;
                end

                // Reset counter after checking for three cycles
                if (count_w_ones >= 3) begin
                    count_w_ones <= 0;
                end
            end
        end
    end

    always_comb begin
        case (current_state)
            A: begin
                if (s == 1) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end

            B: begin
                // Remain in state B to continue checking w
                next_state = B;
            end

            default: begin
                next_state = A;  // Default case for safety
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
