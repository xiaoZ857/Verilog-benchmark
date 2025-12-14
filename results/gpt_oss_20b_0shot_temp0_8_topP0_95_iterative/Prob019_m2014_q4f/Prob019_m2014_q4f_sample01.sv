
// TopModule.v
// 2‑input AND gate where the second input is inverted (bubble)
// out = in1 & ~in2

`timescale 1ns / 1ps
`default_nettype none

module TopModule (
    input  logic in1,
    input  logic in2,
    output logic out
);

    // Combinational logic: out = in1 AND NOT in2
    assign out = in1 & ~in2;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
