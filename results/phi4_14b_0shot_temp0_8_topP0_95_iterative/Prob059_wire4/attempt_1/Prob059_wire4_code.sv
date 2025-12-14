
module TopModule (
    input a,
    input b,
    input c,
    output w,
    output x,
    output y,
    output z
);

// Directly assign each input to its respective output(s)
assign w = a;
assign x = b;
assign y = b;
assign z = c;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
