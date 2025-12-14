
`timescale 1ns / 1ps

// 4‑state Moore machine
//  State A  – output 0
//  State B  – output 0
//  State C  – output 0
//  State D  – output 1
//
//  Next‑state logic (in = 0 / 1)
//      A : A , B
//      B : C , B
//      C : A , D
//      D : C , B
//
//  Reset (active‑high, synchronous) → state A
module TopModule (
    input  wire clk,    // clock
    input  wire in,     // input
    input  wire reset,  // active‑high synchronous reset
    output wire out     // state‑dependent output
);

    // -------------------------------------------------------------
    //  State encoding
    // -------------------------------------------------------------
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // Current state register
    state_t state, next_state;

    // -------------------------------------------------------------
    //  State register – synchronous with active‑high reset
    // -------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (reset)
            state <= STATE_A;          // reset to A
        else
            state <= next_state;       // normal state transition
    end

    // -------------------------------------------------------------
    //  Next‑state logic (combinational)
    // -------------------------------------------------------------
    always_comb begin
        // Default: stay in current state (safety)
        next_state = state;

        // Choose next state based on current state and input
        case (state)
            STATE_A: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            STATE_B: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            STATE_C: next_state = (in == 1'b0) ? STATE_A : STATE_D;
            STATE_D: next_state = (in == 1'b0) ? STATE_C : STATE_B;
            default: next_state = STATE_A; // safety fallback
        endcase
    end

    // -------------------------------------------------------------
    //  Output logic – Moore: output depends only on current state
    // -------------------------------------------------------------
    assign out = (state == STATE_D) ? 1'b1 : 1'b0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
