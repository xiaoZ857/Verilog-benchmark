
// ------------------------------------------------------------
// 2‑to‑1 Multiplexer – TopModule
// ------------------------------------------------------------
//  a, b : 100‑bit input operands
//  sel  : 1‑bit selector (0 → a, 1 → b)
//  out  : 100‑bit output
// ------------------------------------------------------------

`timescale 1ns / 1ps

module TopModule (
    input  wire [99:0] a,   // First operand
    input  wire [99:0] b,   // Second operand
    input  wire        sel, // Selector: 0 selects a, 1 selects b
    output wire [99:0] out  // Result
);

    // Combinational assignment – no clock needed
    assign out = sel ? b : a;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
