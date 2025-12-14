
module TopModule (
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

// Define states for the FSM
typedef enum logic [2:0] {
    IDLE = 3'b000, // Initial state, not detected any part of the sequence yet
    S1 = 3'b001,   // Detected a '1'
    S11 = 3'b010,  // Detected two consecutive '1's
    S110 = 3'b011, // Detected the sequence '110'
    FOUND = 3'b100 // Sequence '1101' is completely detected
} state_t;

// Declare current and next state variables
state_t current_state, next_state;

always_ff @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= IDLE; // Synchronous reset to initial state
    else
        current_state <= next_state;
end

// State transition logic
always_comb begin
    case (current_state)
        IDLE: 
            if (data == 1'b1)
                next_state = S1;
            else
                next_state = IDLE;

        S1:
            if (data == 1'b1)
                next_state = S11;
            else
                next_state = IDLE;

        S11:
            if (data == 1'b0)
                next_state = S110;
            else
                next_state = S11; // Stay in this state if another '1' is detected

        S110:
            if (data == 1'b1)
                next_state = FOUND;
            else
                next_state = IDLE;

        FOUND: 
            next_state = FOUND; // Remain in this state indefinitely until reset

        default: 
            next_state = IDLE;
    endcase
end

// Output logic based on the current state
always_ff @(posedge clk) begin
    if (current_state == FOUND)
        start_shifting <= 1'b1;
    else
        start_shifting <= 1'b0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
