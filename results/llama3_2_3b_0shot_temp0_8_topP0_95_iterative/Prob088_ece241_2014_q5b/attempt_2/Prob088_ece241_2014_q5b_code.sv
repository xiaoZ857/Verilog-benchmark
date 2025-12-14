
module TopModule(
    // Clock and Reset inputs
    input clk,
    input areset_n, // Note: areset is asynchronous active-high
    
    // Input signal
    input x,
    
    // Output signal
    output [1:0] z // Note: Using one-hot encoding for the output signal 'z'
);

// State variables (one-hot encoded)
reg [1:0] state = 2'b00; // Initial state is A

// Next state variables
reg next_state;

// Define states and their corresponding next states
parameter [1:0] STATE_A = 2'b00;
parameter [1:0] STATE_B = 2'b10;

always @(posedge clk) begin
    // Asynchronous active-high reset
    if (areset_n == 0) state <= STATE_A; // Reset into state A
end

assign next_state = state;
assign z = {state, !state}; // Output signal 'z' is one-hot encoded

always @(posedge clk or @(negedge areset_n)) begin
    // Computation of next states based on the current state and input x
    case(state)
        STATE_A: 
            if (x == 0) next_state = STATE_A;
            else if (x == 1) next_state = STATE_B;
        STATE_B:
            if (x == 0) next_state = STATE_B;
            else if (x == 1) next_state = STATE_A;
    endcase
end

assign state = next_state;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
