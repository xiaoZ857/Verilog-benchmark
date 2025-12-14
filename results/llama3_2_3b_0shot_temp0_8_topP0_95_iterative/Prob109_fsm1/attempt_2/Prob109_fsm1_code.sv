
// Define the states of the state machine
typedef enum reg ([2:0]) {
    A_0, // State A at 0 clock cycle
    B_1  // State B at 1 clock cycle
} States;

// Define the next state for each transition
reg [2:0] nextState;
States currState;

// Initialize the states
States initialState = A_0;
currState = initialState; // Set initial state to 1

module TopModule (
    input clk,         // Clock signal
    input in,          // Input signal
    input areset,      // Asynchronous reset signal (high)
    output out        // Output of the state machine
);

// State machine logic
always @(posedge clk) begin
    if (areset && currState == initialState) {
        currState <= B_1; // Reset to state B on high reset
    } else {
        nextState = {
            {0, 0, 2},   // A_0 -> B_1 (clock cycle 1)
            {1, 0, 0},   // B_1 -> B (clock cycle 2)
            {1, 1, 0}    // B -> A (clock cycle 3)
        };
        
        currState = nextState;
    }
end

assign out = currState; // Output is equal to the current state

// Asynchronous clock edge detection (required for asynchronous resets)
always @(posedge clk) begin
    // No change in clock edges needed
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
