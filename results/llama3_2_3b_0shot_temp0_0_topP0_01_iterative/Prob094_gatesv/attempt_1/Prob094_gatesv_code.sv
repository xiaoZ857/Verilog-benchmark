
module TopModule (
    input [3:0] in, // four-bit input vector
    output [2:0] out_both, // output vector indicating both bits are 1
    output [3:1] out_any, // output vector indicating any bit is 1
    output [3:0] out_different // output vector indicating different bits
);

    assign out_both[0] = in[0] & in[1];
    assign out_both[1] = in[1] & in[2];
    assign out_both[2] = in[2] & in[3];

    assign out_any[0] = in[0] | in[1];
    assign out_any[1] = in[1] | in[2];
    assign out_any[2] = in[2] | in[3];

    assign out_different[0] = in[0] ^ in[1]; // wrap around for in[3]'s neighbour
    assign out_different[1] = in[1] ^ in[2];
    assign out_different[2] = in[2] ^ in[3];
    assign out_different[3] = in[3] ^ in[0]; // wrap around for in[0]'s neighbour

endmodule

// VERILOG-EVAL: errant inclusion of module definition
