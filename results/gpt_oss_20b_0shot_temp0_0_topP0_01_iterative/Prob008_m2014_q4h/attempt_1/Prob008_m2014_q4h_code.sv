
// TopModule.v
// -------------------------------------------
//  Simple combinational pass‑through
// -------------------------------------------
//  The output `out` is driven directly by the input `in`.
//  No clock or reset is required – the assignment is purely combinational.
// -------------------------------------------

`timescale 1ns / 1ps   // (optional, for simulation only)

module TopModule (
    input  wire in,   // 1‑bit input
    output wire out   // 1‑bit output
);

    // Combinational assignment
    assign out = in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
