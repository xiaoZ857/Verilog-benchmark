
// State Machine Module

// Define the one-hot state encoding
typedef enum logic[3:0]
{
    A = 4'b0001,
    B = 4'b0010,
    C = 4'b0100,
    D = 4'b1000
} State;

module TopModule (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// Initialize the current state to A
reg [3:0] curr_state = A;

// Define the state transition table
always @(posedge clk)
begin
    // Determine the next state based on the current state and input signal
    case(curr_state)
        A: if(in == 1'b0) next_state = A; else next_state = B;
        B: if(in == 1'b0) next_state = B; else next_state = C;
        C: if(in == 1'b0) next_state = A; else next_state = D;
        D: if(in == 1'b0) next_state = C; else next_state = B;
    endcase

    // Update the current state
    curr_state = next_state;
end

// Define the output logic based on the next state
assign out = (curr_state == D) ? 1'b1 : 1'b0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
