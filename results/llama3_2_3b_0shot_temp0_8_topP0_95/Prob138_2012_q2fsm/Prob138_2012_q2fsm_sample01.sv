
// Define the state machine states and next state logic
module TopModule(
    input clk,
    input reset,
    input w,
    output reg [2:0] A, // State A, B, C, D, E, F
    output z          // FSM output
);

reg [2:0] A_prev;
reg [2:0] A_next;
reg [2:0] q;      // Actual current state

// Initialize the states to their initial values
A_prev = 2'b00;

// State table logic
always @(posedge clk or reset) begin
    if (reset == 1)
        A <= A_prev;
    else
        A_next <= A_prev;
    
    case(A_prev)
        2'b00: // A(0)
            A_next = w ? 2'b01 : A_prev; // A(0) -> B(0) or A(0)
            break;
        2'b01: // A(1)
            A_next = w ? 2'b10 : A_prev; // A(1) -> C(0)
            break;
        2'b10: // B(0)
            A_next = w ? 2'b11 : A_prev; // B(0) -> D(0)
            break;
        2'b11: // B(1)
            A_next = w ? 2'b00 : A_prev; // B(1) -> A(1) or D(0)
            break;
        2'b10: // C(0)
            A_next = w ? 2'b01 : A_prev; // C(0) -> E(0)
            break;
        2'b11: // C(1)
            A_next = w ? 2'b00 : A_prev; // C(1) -> D(0)
            break;
        2'b10: // D(0)
            A_next = w ? 2'b01 : A_prev; // D(0) -> F(0)
            break;
        default:
            A_next = A_prev; // Invalid state
            break;
    endcase
    
    q <= A_next;
end

// z is the output of the state machine, it's a function of the current state and input w
always @(posedge clk) begin
    if (q == 2'b11 && !w)
        z = 1;
    else
        z = 0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
