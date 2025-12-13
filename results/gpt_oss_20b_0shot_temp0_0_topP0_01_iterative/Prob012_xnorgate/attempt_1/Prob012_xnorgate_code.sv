
// ------------------------------------------------------------
//  TopModule : 2‑input XNOR gate
// ------------------------------------------------------------
//  Inputs:
//      a, b   – 1‑bit logic inputs
//  Output:
//      out    – 1‑bit logic output (XNOR of a and b)
// ------------------------------------------------------------

`timescale 1ns / 1ps   // (optional) useful for simulation

module TopModule (
    input  wire a,      // first input
    input  wire b,      // second input
    output wire out     // XNOR result
);

    // Continuous assignment – synthesizable combinational logic
    assign out = ~(a ^ b);   // XNOR: out = 1 when a == b, else 0

    // Alternative (more readable) form:
    // assign out = (a == b);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
