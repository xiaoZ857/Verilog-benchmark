
// ------------------------------------------------------------
//  Full Adder
//  Adds three 1‑bit operands (a, b, cin) and produces
//  a 1‑bit sum and a 1‑bit carry‑out (cout).
//
//  Inputs:
//      a      – first operand
//      b      – second operand
//      cin    – carry‑in
//
//  Outputs:
//      sum    – sum of a, b and cin
//      cout   – carry‑out of the addition
//
//  Note:  This module is combinational; no clock is used.
// ------------------------------------------------------------
`timescale 1ns / 1ps

module TopModule (
    input  wire a,      // first operand
    input  wire b,      // second operand
    input  wire cin,    // carry‑in
    output wire cout,   // carry‑out
    output wire sum     // sum
);

// Sum is the XOR of all three inputs
assign sum = a ^ b ^ cin;

// Carry‑out is true if at least two of the inputs are 1
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
