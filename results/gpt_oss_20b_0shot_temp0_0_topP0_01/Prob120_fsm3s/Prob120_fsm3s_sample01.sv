
//=====================================================================
//  TopModule.v
//  Moore FSM – 4 states (A,B,C,D) with one input (in) and one output
//  (out).  The FSM is synchronously reset (active‑high) to state A.
//  The state transition table is:
//
//  State | Next state (in=0) | Next state (in=1) | Output
//  -----------------------------------------------------
//  A     | A                 | B                 | 0
//  B     | C                 | B                 | 0
//  C     | A                 | D                 | 0
//  D     | C                 | B                 | 1
//
//  The output is a Moore output – it depends only on the current state.
//=====================================================================

`timescale 1ns/1ps
`default_nettype none

module TopModule (
    input  wire clk,     // Clock (positive edge)
    input  wire in,      // Input
    input  wire reset,   // Synchronous active‑high reset
    output reg  out      // Output
);

    //-----------------------------------------------------------------
    // State encoding (2‑bit)
    //  A = 2'b00
    //  B = 2'b01
    //  C = 2'b10
    //  D = 2'b11
    //-----------------------------------------------------------------
    localparam [1:0] STATE_A = 2'b00,
                     STATE_B = 2'b01,
                     STATE_C = 2'b10,
                     STATE_D = 2'b11;

    reg [1:0] state, next_state;

    //-----------------------------------------------------------------
    // State register – synchronous update with active‑high reset
    //-----------------------------------------------------------------
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_A;          // Reset to state A
        end else begin
            state <= next_state;       // Normal state transition
        end
    end

    //-----------------------------------------------------------------
    // Next‑state logic (combinational)
    //-----------------------------------------------------------------
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in == 1'b0) next_state = STATE_A;
                else            next_state = STATE_B;
            end
            STATE_B: begin
                if (in == 1'b0) next_state = STATE_C;
                else            next_state = STATE_B;
            end
            STATE_C: begin
                if (in == 1'b0) next_state = STATE_A;
                else            next_state = STATE_D;
            end
            STATE_D: begin
                if (in == 1'b0) next_state = STATE_C;
                else            next_state = STATE_B;
            end
            default: next_state = STATE_A; // Safety net
        endcase
    end

    //-----------------------------------------------------------------
    // Output logic – Moore output (depends only on current state)
    //-----------------------------------------------------------------
    always @(*) begin
        case (state)
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
