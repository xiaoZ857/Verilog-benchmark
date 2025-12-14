
// ---------------------------------------------------------------
//  Module: TopModule
//  Purpose: Compute the minimum of four 8‑bit unsigned inputs
//  Author : ChatGPT
// ---------------------------------------------------------------

`timescale 1ns/1ps

module TopModule (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [7:0] c,
    input  wire [7:0] d,
    output reg  [7:0] min          // min is declared as a reg because we assign it
);

    // ---------------------------------------------
    //  Combinational logic – no clock involved
    // ---------------------------------------------
    always @* begin
        // First, find the min of a & b
        reg [7:0] min_ab;
        if (a < b)
            min_ab = a;
        else
            min_ab = b;

        // Then, find the min of c & d
        reg [7:0] min_cd;
        if (c < d)
            min_cd = c;
        else
            min_cd = d;

        // Finally, compare the two intermediate mins
        if (min_ab < min_cd)
            min = min_ab;
        else
            min = min_cd;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
