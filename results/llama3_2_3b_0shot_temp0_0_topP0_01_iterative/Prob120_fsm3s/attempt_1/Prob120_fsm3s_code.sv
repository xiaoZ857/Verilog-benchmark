
module TopModule(
    input clk,
    input in,
    input reset,
    output out
);

// Define the states and their corresponding next states
typedef enum logic [1:0] state_type {
    A, B, C, D
} state_type;

state_type current_state = 'a; // Initialize to state A

always @(posedge clk) begin
    if (reset) begin
        current_state <= A;
    end else begin
        case (current_state)
            A:      if (!in) current_state <= B; else current_state <= A;
            B:      if (!in) current_state <= C; else current_state <= B;
            C:      if (!in) current_state <= D; else current_state <= C;
            D:      if (!in) current_state <= B; else current_state <= D;
        endcase
    end
end

always @(posedge clk or posedge reset) begin
    out <= (current_state == A) ? 0 : 1;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
