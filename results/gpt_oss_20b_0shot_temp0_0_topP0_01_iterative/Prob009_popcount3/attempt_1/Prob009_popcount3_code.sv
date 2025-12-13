
// ------------------------------------------------------------
//  TopModule.v
//  3‑bit population‑count (popcount) circuit
// ------------------------------------------------------------

`timescale 1ns / 1ps

module TopModule (
    input  wire [2:0] in,   // 3‑bit input vector
    output wire [1:0] out   // 2‑bit output: number of '1's (0‑3)
);

    // --------------------------------------------------------
    //  Combinational logic
    // --------------------------------------------------------
    // The simplest way is to add the three bits together.
    // Since the sum of three 1‑bit numbers fits in 2 bits,
    // we can use a 2‑bit adder.
    assign out = in[0] + in[1] + in[2];

    // --------------------------------------------------------
    //  Alternative (explicit logic) – useful for learning
    // --------------------------------------------------------
    // assign out[0] = in[0] ^ in[1] ^ in[2];          // LSB of the count
    // assign out[1] = (in[0] & in[1]) | (in[0] & in[2]) | (in[1] & in[2]); // MSB

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
