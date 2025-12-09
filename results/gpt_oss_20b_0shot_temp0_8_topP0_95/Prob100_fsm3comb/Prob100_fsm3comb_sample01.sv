
//=======================================================================
//  TopModule
//  Combinational part of a 4‑state Moore machine
//  State encoding:
//      A = 2'b00
//      B = 2'b01
//      C = 2'b10
//      D = 2'b11
//
//  Inputs:
//      in   – single‑bit input
//      state – 2‑bit current state
//
//  Outputs:
//      next_state – 2‑bit next state (combinational)
//      out        – 1‑bit Moore output
//=======================================================================
module TopModule (
    input  wire        in,      // current input
    input  wire [1:0]  state,   // current state
    output reg  [1:0]  next_state, // next state (combinational)
    output wire        out       // Moore output
);

    //----- Output logic (Moore) ---------------------------------------
    // Output depends only on the current state.
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;   // 1 only in state D

    //----- State‑transition logic ------------------------------------
    // Combinational always block – no clock required.
    always @(*) begin
        case (state)
            2'b00 :  // State A
                next_state = (in) ? 2'b01 : 2'b00;   // A or B
            2'b01 :  // State B
                next_state = (in) ? 2'b01 : 2'b10;   // B or C
            2'b10 :  // State C
                next_state = (in) ? 2'b11 : 2'b00;   // D or A
            2'b11 :  // State D
                next_state = (in) ? 2'b01 : 2'b10;   // B or C
            default: // safety for undefined states
                next_state = 2'b00;                   // default to A
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
