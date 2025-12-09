
// TopModule.v
// 2‑to‑1 mux – choose `b` only when both sel_b1 and sel_b2 are high.
// The same logic is shown twice: once with a continuous `assign`,
// once with a procedural `always` block.

`timescale 1ns/1ps

module TopModule (
    input  wire a,          // first data input
    input  wire b,          // second data input
    input  wire sel_b1,     // first selector
    input  wire sel_b2,     // second selector
    output wire out_assign, // driven by a continuous assignment
    output reg  out_always  // driven by a procedural block
);

    // ------------- 1) Continuous assignment (assign) ----------------
    // When both selectors are high, pick `b`; otherwise pick `a`.
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // ------------- 2) Procedural if statement (always) -------------
    // Combinational always block – no clock is required.
    always @(*) begin
        if (sel_b1 && sel_b2)
            out_always = b;
        else
            out_always = a;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
