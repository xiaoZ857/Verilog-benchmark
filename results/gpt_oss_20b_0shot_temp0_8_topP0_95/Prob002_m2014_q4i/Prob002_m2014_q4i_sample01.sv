
// TopModule.v
// -------------------------------------
// This module has no inputs and drives its single output
// 'out' constantly to logic low (0) on every clock edge.

module TopModule (
    output out
);

    // Continuous assignment – out is always 0
    assign out = 1'b0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
