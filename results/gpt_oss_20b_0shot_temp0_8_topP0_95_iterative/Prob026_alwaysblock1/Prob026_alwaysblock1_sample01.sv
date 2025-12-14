
// -----------------------------------------------------------------------------
//  TopModule
//  ---------
//  Implements a 2‑input AND gate in two different ways:
//
//    1)  out_assign   – combinational logic written with a continuous
//        assign statement.
//
//    2)  out_alwaysblock – combinational logic written inside an
//        always @* block.  The output is declared as a *reg* because
//        it is driven by procedural code.
//
//  The module contains no clock – all signals are purely combinational.
// -----------------------------------------------------------------------------
`timescale 1ns/1ps

module TopModule (
    input  wire a,                // First AND input
    input  wire b,                // Second AND input
    output wire out_assign,       // AND result via assign
    output reg  out_alwaysblock   // AND result via always block
);

// 1) Continuous assignment – straightforward
assign out_assign = a & b;

// 2) Procedural assignment – combinational always block
//    The sensitivity list is automatically inferred as @(*).
//    Using `reg` for out_alwaysblock is required in older Verilog
//    standards; in SystemVerilog you could use an automatic wire.
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
