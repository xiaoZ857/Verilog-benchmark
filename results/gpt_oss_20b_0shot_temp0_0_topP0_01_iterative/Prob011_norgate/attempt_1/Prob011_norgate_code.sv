
// TopModule.v
// 2‑input NOR gate
//   out = NOT (a OR b)

`timescale 1ns / 1ps

module TopModule (
    input  wire a,   // first input
    input  wire b,   // second input
    output wire out  // NOR output
);

    // Gate‑level instantiation (most compact)
    nor (out, a, b);

    // Alternative: continuous assignment
    // assign out = ~(a | b);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
