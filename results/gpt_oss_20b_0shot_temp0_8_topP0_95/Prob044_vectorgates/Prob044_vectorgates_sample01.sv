
// -------------------------------------------------------------
//  TopModule
//  ---------
//  Inputs:
//      a [2:0]  – first 3‑bit vector
//      b [2:0]  – second 3‑bit vector
//
//  Outputs:
//      out_or_bitwise  – bit‑wise OR of a and b
//      out_or_logical  – logical (reduction) OR of a and b
//      out_not [5:0]   – 6‑bit vector containing ~b (upper 3 bits)
//                        and ~a (lower 3 bits)
// -------------------------------------------------------------
`timescale 1ns / 1ps

module TopModule (
    input  wire [2:0] a,
    input  wire [2:0] b,
    output wire [2:0] out_or_bitwise,
    output wire       out_or_logical,
    output wire [5:0] out_not
);

    // Bit‑wise OR of the two 3‑bit vectors
    assign out_or_bitwise = a | b;

    // Logical OR (reduction OR) – 1 if any bit of a or b is 1
    assign out_or_logical = |a | |b;

    // Inverted vectors: upper half = ~b, lower half = ~a
    assign out_not = { ~b, ~a };

endmodule

// VERILOG-EVAL: errant inclusion of module definition
