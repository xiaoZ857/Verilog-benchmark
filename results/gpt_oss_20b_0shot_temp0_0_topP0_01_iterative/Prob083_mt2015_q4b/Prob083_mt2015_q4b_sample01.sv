
// TopModule.v
// -------------
//  Combinational XNOR of two 1‑bit inputs.
//  The waveform in the problem statement matches the truth table of an XNOR gate.
//
//  Inputs:
//      x : 1‑bit input
//      y : 1‑bit input
//
//  Output:
//      z : 1‑bit output (z = x XNOR y)
//
//  Note:  No clock is required – the logic is purely combinational.
//  The module is written in two equivalent styles: a continuous assignment
//  and an always @(*) block.  Either style is acceptable for synthesis.

`timescale 1ns / 1ps

module TopModule (
    input  wire x,
    input  wire y,
    output wire z
);

// ------------------------------------------------------------------
// 1) Continuous assignment (preferred for simple combinational logic)
// ------------------------------------------------------------------
assign z = ~(x ^ y);          // XNOR: 1 when x == y, 0 otherwise

// ------------------------------------------------------------------
// 2) Alternative always @(*) block (useful if you want to add
//    additional logic later)
// ------------------------------------------------------------------
/*
always @(*) begin
    z = ~(x ^ y);   // same as above
end
*/

endmodule

// VERILOG-EVAL: errant inclusion of module definition
