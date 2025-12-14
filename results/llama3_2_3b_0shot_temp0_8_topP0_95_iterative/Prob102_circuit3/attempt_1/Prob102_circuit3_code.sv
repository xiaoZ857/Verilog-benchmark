
module TopModule (
    input a,        // clock signal
    input b,        // reset signal (asserted on clock edges)
    input c,        // data line 'c'
    input d,        // data line 'd'
    output q        // output signal 'q'
);

    assign q = ~(a & c) | (b ^ d);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
