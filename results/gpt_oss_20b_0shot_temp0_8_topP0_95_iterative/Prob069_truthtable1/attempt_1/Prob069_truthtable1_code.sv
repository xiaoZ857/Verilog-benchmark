
// --------------------------------------------------------------------
//  Module : TopModule
//  Purpose: Implements the combinational function
//          f = (~x3 & x2) | (x3 & x1)
//  This expression is derived from the given truth table.
// --------------------------------------------------------------------
`timescale 1ns/1ps

module TopModule (
    input  wire x3,   // Most significant input
    input  wire x2,   // Middle input
    input  wire x1,   // Least significant input
    output wire f     // Resulting output
);

// Continuous assignment – pure combinational logic
assign f = (~x3 & x2) | (x3 & x1);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
