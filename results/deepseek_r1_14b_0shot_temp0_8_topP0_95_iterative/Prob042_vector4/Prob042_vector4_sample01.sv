
// This sets the simulation time units (optional for synthesis)
`timescale 1ns/1ps

module TopModule (
    input [7:0] in,
    output [31:0] out
);

    // Sign-extend the MSB (bit 7) of the 8-bit input to 24 bits and concatenate with original input
    assign out = $repl(in[7], 24) << 8 | in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
