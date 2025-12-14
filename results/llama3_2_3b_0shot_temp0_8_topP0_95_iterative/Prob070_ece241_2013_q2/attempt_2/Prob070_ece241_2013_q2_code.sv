
module TopModule (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    assign out_sop = (a&b&c) | (a&b&d) | (a&c&d) | (b&c&d);
    assign out_pos = ~(~a|b|c) & ~(~a|d|c) & ~(~b|d|c) & ~(~a|d|b);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
