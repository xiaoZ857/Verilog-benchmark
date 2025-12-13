
// ------------------------------------------------------------
//  TopModule
//  2‑to‑1 multiplexer
//  • out_assign  – continuous‑assignment (assign)
//  • out_always – procedural if‑statement (always @(*))
// ------------------------------------------------------------
`timescale 1ns/1ps

module TopModule (
    input  wire a,          // first data input
    input  wire b,          // second data input
    input  wire sel_b1,     // first select signal
    input  wire sel_b2,     // second select signal
    output wire out_assign, // result from continuous assignment
    output reg  out_always  // result from procedural block
);

    // --------------------------------------------------------
    // 1) Continuous assignment (assign)
    //    Choose b if both sel_b1 and sel_b2 are true,
    //    otherwise choose a.
    // --------------------------------------------------------
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // --------------------------------------------------------
    // 2) Procedural if‑statement (always @(*))
    //    Same logic as above, but written in a procedural block.
    // --------------------------------------------------------
    always @(*) begin
        if (sel_b1 && sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
