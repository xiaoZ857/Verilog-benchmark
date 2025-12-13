
// TopModule.v
// -------------
// A module with no inputs and a single output that is permanently driven high.
// The output is a wire (the default for an output port) and is assigned a
// constant logic‑high value using a continuous assignment.

`timescale 1ns / 1ps   // (optional – useful for simulation)

module TopModule (
    output one          // single output port
);

// Continuous assignment – drives the output high at all times
assign one = 1'b1;      // 1'b1 is a 1‑bit logic high

endmodule

// VERILOG-EVAL: errant inclusion of module definition
