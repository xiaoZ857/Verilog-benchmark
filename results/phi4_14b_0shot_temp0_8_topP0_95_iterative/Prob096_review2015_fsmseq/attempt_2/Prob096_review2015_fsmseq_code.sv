
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
// Define states for the FSM
typedef enum logic [3:0] {
    IDLE = 4'b0000, // Initial state, not detected any part of the sequence yet
    S1 = 4'b0001,   // Detected a '1'
    S11 = 4'b0010,  // Detected two consecutive '1's
    S110 = 4'b0100, // Detected the sequence '110'
    S1101 = 4'b1000,// Detected the complete sequence '1101'
    FOUND = 4'b1111 // Sequence '1101' is completely detected
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
                next_state = S1101;
            else
                next_state = IDLE;

        S1101:
            if (data == 1'b1)
                next_state = FOUND; // Correctly transition to FOUND only on '1'
            else
                next_state = IDLE; // If not '1', reset the sequence

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

// VERILOG-EVAL: endmodule not found
