
// 2‑state Moore machine
//  - State B : out = 1
//  - State A : out = 0
//  Transitions:
//      B --in=0--> A
//      B --in=1--> B
//      A --in=0--> B
//      A --in=1--> A
//  Active‑high synchronous reset puts the machine in state B.

module TopModule (
    input  wire clk,      // clock
    input  wire in,       // input
    input  wire reset,    // synchronous active‑high reset
    output wire out       // Moore output
);

    // State encoding
    localparam B = 1'b0,
               A = 1'b1;

    reg   state, next_state;   // current & next state

    // State register (synchronous reset)
    always @(posedge clk) begin
        if (reset)
            state <= B;          // reset to B
        else
            state <= next_state; // normal state transition
    end

    // Next‑state logic (combinational)
    always @(*) begin
        case (state)
            B: next_state = (in == 1'b0) ? A : B;
            A: next_state = (in == 1'b0) ? B : A;
            default: next_state = B; // safety fallback
        endcase
    end

    // Output logic (Moore – depends only on state)
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
