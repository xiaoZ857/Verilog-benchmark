
module TopModule(
    input clk, // Positive edge triggered clock
    input aresetn, // Negative edge triggered asynchronous reset
    input x, // Input signal to be recognized
    output reg z // Output signal to indicate detection of the sequence "101"
);

// Define the states of the finite state machine
typedef enum logic [1:0] {
    S0,  // Initial state
    S1,  // State after detecting '1'
    S2   // Final state after detecting '01'
} States;

// Initialize the current state to S0
reg [1:0] currentState = S0;
reg [1:0] nextState = S0; // Next state

// Define the output signal z as 1 when the sequence "101" is detected
reg z = 0;

// Asynchronous reset
always @(posedge aresetn) {
    currentState <= S0;
}

// Mealy-type finite state machine
always @(posedge clk or negedge aresetn) begin
    // If the input signal x is '1', transition to S1
    if (x == 1'b1) {
        nextState <= S1;
    }
    // If the current state is S0 and the next state is S2, set z to 1
    else if (currentState == S0 && nextState == S2) {
        z <= 1'b1;
    }
    // Update the current state
    currentState <= nextState;
end

// Output signal z
assign z = z;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
