
//=====================================================================
//  TopModule.v
//  100‑input combinational logic block
//
//  Inputs:
//      in[99:0]  – 100‑bit wide input vector
//
//  Outputs:
//      out_and   – 1‑bit AND of all 100 inputs
//      out_or    – 1‑bit OR  of all 100 inputs
//      out_xor   – 1‑bit XOR of all 100 inputs
//
//  All outputs are purely combinational (no clocking required).
//=====================================================================

`timescale 1ns / 1ps

module TopModule (
    input  wire [99:0] in,      // 100‑bit input vector
    output wire        out_and, // 100‑input AND
    output wire        out_or,  // 100‑input OR
    output wire        out_xor  // 100‑input XOR
);

    // Reduction operators – synthesised as a single wide AND/OR/XOR gate
    assign out_and = &in;   // 100‑input AND
    assign out_or  = |in;   // 100‑input OR
    assign out_xor = ^in;   // 100‑input XOR

endmodule

// VERILOG-EVAL: errant inclusion of module definition
