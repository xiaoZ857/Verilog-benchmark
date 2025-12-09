
// TopModule.v
// -------------
// Finds the minimum of four 8‑bit unsigned inputs.
// The module is combinational – the output `min` updates
// whenever any of the inputs change.
//
// Author: <your name>
// Date:   <date>
//

`timescale 1ns / 1ps

module TopModule (
    input  wire [7:0] a,      // first operand
    input  wire [7:0] b,      // second operand
    input  wire [7:0] c,      // third operand
    input  wire [7:0] d,      // fourth operand
    output reg  [7:0] min     // minimum of a,b,c,d
);

    // --------------------------------------------------------------------
    // Combinational logic: find the smallest value.
    // --------------------------------------------------------------------
    always @(*) begin
        // Start with a as the provisional minimum
        min = a;

        // Compare against each other operand
        if (b < min) min = b;
        if (c < min) min = c;
        if (d < min) min = d;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
