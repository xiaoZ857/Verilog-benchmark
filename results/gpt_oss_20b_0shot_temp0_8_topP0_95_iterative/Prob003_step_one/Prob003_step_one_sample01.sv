
// TopModule.v
// Description:  No inputs – single output that is always driven high (logic '1').

`timescale 1ns / 1ps

module TopModule (
    output one          // output that should always be logic high
);

    // Continuous assignment – the output is permanently tied to logic '1'
    assign one = 1'b1;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
