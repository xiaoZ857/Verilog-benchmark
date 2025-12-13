
// 3‑bit synchronous FSM with active‑high reset
//  Present state  y[2:0]  |  Next state (x=0) | Next state (x=1) | Output z
//  000 | 000 | 001 | 0
//  001 | 001 | 100 | 0
//  010 | 010 | 001 | 0
//  011 | 001 | 010 | 1
//  100 | 011 | 100 | 1

module TopModule (
    input  wire clk,    // clock
    input  wire reset,  // synchronous active‑high reset
    input  wire x,      // input
    output reg  z       // output
);

    // State encoding
    localparam  S0 = 3'b000,
                S1 = 3'b001,
                S2 = 3'b010,
                S3 = 3'b011,
                S4 = 3'b100;

    // State register
    reg [2:0] y;          // present state

    // ------------------------------------------------------------------
    // State transition (sequential logic)
    // ------------------------------------------------------------------
    always @(posedge clk) begin
        if (reset) begin
            y <= S0;          // synchronous reset to state 000
        end else begin
            y <= next_state;  // update to next state
        end
    end

    // ------------------------------------------------------------------
    // Next‑state logic (combinational)
    // ------------------------------------------------------------------
    reg [2:0] next_state;

    always @(*) begin
        case (y)
            S0: next_state = (x == 1'b0) ? S0 : S1;
            S1: next_state = (x == 1'b0) ? S1 : S4;
            S2: next_state = (x == 1'b0) ? S2 : S1;
            S3: next_state = (x == 1'b0) ? S1 : S2;
            S4: next_state = (x == 1'b0) ? S3 : S4;
            default: next_state = S0;   // safety default
        endcase
    end

    // ------------------------------------------------------------------
    // Output logic (combinational)
    // ------------------------------------------------------------------
    always @(*) begin
        case (y)
            S3, S4: z = 1'b1;   // states 011 and 100
            default: z = 1'b0;   // all other states
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
