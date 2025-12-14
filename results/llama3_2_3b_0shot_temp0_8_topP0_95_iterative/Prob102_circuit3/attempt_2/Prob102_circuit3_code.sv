
module TopModule (
    input a,
    input b,
    input c,
    input d,
    output q
);

    assign q = ~(a ^ c) | (d ^ c);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
