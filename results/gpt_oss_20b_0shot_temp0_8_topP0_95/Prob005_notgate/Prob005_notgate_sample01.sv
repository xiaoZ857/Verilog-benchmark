
`timescale 1ns/1ps          // (optional) set simulation time unit and precision

module TopModule (
    input  wire in,          // input signal
    output wire out          // output signal (inverted input)
);

    // Combinational logic: output is the logical NOT of the input
    assign out = ~in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
