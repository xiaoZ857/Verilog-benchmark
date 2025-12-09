
// ---------------------------------------------------------------
//  TopModule : 2‑state Moore FSM
//  States :  A (out = 0) ,  B (out = 1)
//  Transition table
//      Current  Input   Next     Output
//        B       0      A        1
//        B       1      B        1
//        A       0      B        0
//        A       1      A        0
//
//  Reset : synchronous, active‑high, forces state = B
// ---------------------------------------------------------------
module TopModule (
    input  wire clk,     // clock
    input  wire in,      // input
    input  wire reset,   // synchronous active‑high reset
    output reg  out      // Moore output (combinational)
);

    // ---------- State encoding ----------
    // Only two states – a single bit is enough
    localparam STATE_A = 1'b0;   // out = 0
    localparam STATE_B = 1'b1;   // out = 1

    // State register
    reg state, next_state;

    // ----------------- State update -----------------
    // Synchronous state register with active‑high reset
    always @(posedge clk) begin
        if (reset)                 // synchronous reset
            state <= STATE_B;      // reset to state B
        else
            state <= next_state;   // normal transition
    end

    // ----------------- Next‑state logic -----------------
    always @(*) begin
        case (state)
            STATE_B: begin
                if (in == 1'b0)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_A: begin
                if (in == 1'b0)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            default: next_state = STATE_B;  // safety net
        endcase
    end

    // ----------------- Output logic (Moore) -----------------
    // Output is purely combinational based on the present state
    always @(*) begin
        case (state)
            STATE_B: out = 1'b1;
            STATE_A: out = 1'b0;
            default: out = 1'b0;      // safety net
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
