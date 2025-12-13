
// TopModule.v
// Computes z = (x ^ y) & x
// All signals are combinational – no clock required.

module TopModule (
    input  wire x,   // First input
    input  wire y,   // Second input
    output wire z    // Result
);

    // Continuous assignment – the result updates immediately
    // whenever x or y changes.
    assign z = (x ^ y) & x;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
