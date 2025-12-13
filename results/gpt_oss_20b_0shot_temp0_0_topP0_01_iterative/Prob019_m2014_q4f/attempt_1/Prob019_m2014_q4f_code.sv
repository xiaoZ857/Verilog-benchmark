
// TopModule.v
// Two inputs (in1, in2) feed an AND gate.
// The in2 line is inverted (bubble) before the AND.
// The result is driven to the output `out`.
//
// The design is purely combinational – no clock is required.

module TopModule (
    input  logic in1,   // First input
    input  logic in2,   // Second input (will be inverted)
    output logic out    // Result of in1 AND (NOT in2)
);

    // Combinational logic: out = in1 & ~in2
    assign out = in1 & ~in2;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
