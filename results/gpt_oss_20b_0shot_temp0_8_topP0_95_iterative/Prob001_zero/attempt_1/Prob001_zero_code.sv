
// TopModule.v
`timescale 1ns / 1ps

module TopModule (
    output zero
);
    // Continuous assignment – zero is always driven low
    assign zero = 1'b0;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
