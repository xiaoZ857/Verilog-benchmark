
module TopModule(
    input clk, // Positive clock/clk triggered
    input in,   // Input signal
    input reset, // Reset active-high synchronous
    output out  // Output signal
);

// Define the states
typedef enum logic [1:0] state {
    B,
    A
} state_type;

// Initialize the current state to B (reset state)
state_type currentState = B;

always @(posedge clk) begin
    if (reset) begin
        // Reset active-high synchronous, set currentState to B
        currentState = B;
    end else if (currentState == B && in == 0) begin
        // B -> A transition on input 0
        currentState = A;
    end else if (currentState == B && in == 1) begin
        // B -> B transition on input 1
        currentState = B;
    end else if (currentState == A && in == 0) begin
        // A -> B transition on input 0
        currentState = B;
    end else if (currentState == A && in == 1) begin
        // A -> A transition on input 1
        currentState = A;
    end
end

always @(posedge clk or negedge reset) begin
    out <= (currentState == B) ? 1 : 0; // Output signal based on current state
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
