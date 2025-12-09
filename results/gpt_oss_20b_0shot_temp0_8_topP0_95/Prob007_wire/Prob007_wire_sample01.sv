
// TopModule.v
`timescale 1ns/1ps          // Optional: set simulation time units

module TopModule (
    input  wire in,         // One input signal
    output wire out         // One output signal
);

    // Continuous assignment – behaves like a wire
    assign out = in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
