
// 7420 – Two 4‑input NAND gates
// ------------------------------------------------------------
//  p1y = NAND(p1a, p1b, p1c, p1d)
//  p2y = NAND(p2a, p2b, p2c, p2d)
//
// No clock is involved – the logic is purely combinational.
//
// Author:  <your name>
// Date:    <date>
//
// ------------------------------------------------------------
`timescale 1ns/1ps

module TopModule (
    input  wire p1a,   // Gate‑1 input A
    input  wire p1b,   // Gate‑1 input B
    input  wire p1c,   // Gate‑1 input C
    input  wire p1d,   // Gate‑1 input D
    output wire p1y,   // Gate‑1 output (NAND of the four inputs)

    input  wire p2a,   // Gate‑2 input A
    input  wire p2b,   // Gate‑2 input B
    input  wire p2c,   // Gate‑2 input C
    input  wire p2d,   // Gate‑2 input D
    output wire p2y    // Gate‑2 output (NAND of the four inputs)
);

    // --------------------------------------------------------
    // 4‑input NAND gates – implemented with continuous
    // assignment (gate‑level equivalent)
    // --------------------------------------------------------
    assign p1y = ~(p1a & p1b & p1c & p1d);
    assign p2y = ~(p2a & p2b & p2c & p2d);

    // --------------------------------------------------------
    // Alternative gate‑primitive style (uncomment if you
    // prefer the primitive syntax):
    // --------------------------------------------------------
    // nand (p1y, p1a, p1b, p1c, p1d);
    // nand (p2y, p2a, p2b, p2c, p2d);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
