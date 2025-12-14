
module TopModule (
    input a, 
    input b, 
    input c, 
    input d, 
    output out_sop, 
    output out_pos
);

    always_comb begin : calc_outsop
        out_sop = ~(a&~b|c&d) | (~a&c|d&b) | (a&b&c);
    end

    always_comb begin : calc_outpos
        out_pos = ~((~a&b)&~(c|d)) | ((a|d)&c)&b;
    end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
