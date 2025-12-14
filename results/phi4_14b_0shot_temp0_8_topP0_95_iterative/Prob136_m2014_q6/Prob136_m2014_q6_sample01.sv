
// Define the state encoding using an enum for clarity and maintainability
typedef enum logic [2:0] {
    A = 3'b000,
    B = 3'b001,
    C = 3'b010,
    D = 3'b011,
    E = 3'b100,
    F = 3'b101
} state_t;

module TopModule (
    input logic clk,
    input logic reset,
    input logic w,
    output reg z // Declare as 'reg' since it is driven by combinational logic
);

    // State registers and next state logic
    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            A: next_state = (w == 0) ? B : A;
            B: next_state = (w == 0) ? C : D;
            C: next_state = (w == 0) ? E : D;
            D: next_state = (w == 0) ? F : A;
            E: next_state = (w == 1) ? E : D; // Note the inversion for w
            F: next_state = (w == 1) ? C : D; // Note the inversion for w
            default: next_state = A;
        endcase
    end

    always_comb begin
        case (current_state)
            E: z = 1'b0; // For state E, output is specifically mentioned as 0
            F: z = 1'b1; // For state F, output is specifically mentioned as 1
            default: z = 1'bx; // Undefined for other states
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
