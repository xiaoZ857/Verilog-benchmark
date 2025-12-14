
// -------------
//  Half Adder
// -------------
//  The module adds two 1‑bit inputs (a and b) and produces
//  a 1‑bit sum and a 1‑bit carry‑out (cout).  
//  No carry‑in is required – this is a *half* adder.
//
//  The logic is combinational so the outputs are updated
//  immediately when either input changes.  We use continuous
//  assignment statements for clarity and brevity.
//
//  All signals are positive‑edge triggered by the system clock
//  only when they are inside a clocked block.  Here the logic
//  is purely combinational, so no clock is needed.
//
//  Author:   <Your Name>
//  Date:     <Date>
//  Revision: 1.0
//  -----------------------------

`timescale 1ns / 1ps

module TopModule (
    input  wire a,      // First input bit
    input  wire b,      // Second input bit
    output wire sum,    // Sum bit (a XOR b)
    output wire cout    // Carry-out bit (a AND b)
);

    // Combinational logic
    assign sum  = a ^ b;   // Sum of two bits
    assign cout = a & b;   // Carry out of the addition

endmodule

// VERILOG-EVAL: errant inclusion of module definition
