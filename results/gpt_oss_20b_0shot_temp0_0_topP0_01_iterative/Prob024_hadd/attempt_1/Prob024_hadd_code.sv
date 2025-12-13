
//=====================================================================
//  Half‑Adder
//  Adds two single‑bit inputs (a, b) and produces:
//      sum  – the XOR of the inputs
//      cout – the AND of the inputs (carry out)
//=====================================================================
`timescale 1ns / 1ps

module TopModule (
    input  wire a,      // First operand
    input  wire b,      // Second operand
    output wire sum,    // Sum output (a XOR b)
    output wire cout    // Carry‑out output (a AND b)
);

// Combinational logic
assign sum  = a ^ b;   // XOR gives the sum bit
assign cout = a & b;   // AND gives the carry bit

endmodule

// VERILOG-EVAL: errant inclusion of module definition
