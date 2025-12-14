
module TopModule (
  input wire clk,
  input wire in,
  input wire areset, // Asynchronous reset
  output reg out     // Output signal
);

    // State encoding
    typedef enum logic [1:0] {A, B, C, D} state_t;
    state_t current_state, next_state;

    // Next state logic and output generation
    always_comb begin
        case (current_state)
            A: begin
                out = 0; // Output for state A
                if (!areset) begin
                    next_state = in ? B : A;
                end else begin
                    next_state = A; // Reset to A
                end
            end
            
            B: begin
                out = 0; // Output for state B
                if (!areset) begin
                    next_state = in ? B : C;
                end else begin
                    next_state = A; // Reset to A
                end
            end

            C: begin
                out = 0; // Output for state C
                if (!areset) begin
                    next_state = in ? D : A;
                end else begin
                    next_state = A; // Reset to A
                end
            end

            D: begin
                out = 1; // Output for state D
                if (!areset) begin
                    next_state = in ? B : C;
                end else begin
                    next_state = A; // Reset to A
                end
            end
            
            default: begin
                out = 0;
                if (!areset) begin
                    next_state = A;
                end else begin
                    next_state = A; // Default reset case
                end
            end
        endcase
    end

    // State register update logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
