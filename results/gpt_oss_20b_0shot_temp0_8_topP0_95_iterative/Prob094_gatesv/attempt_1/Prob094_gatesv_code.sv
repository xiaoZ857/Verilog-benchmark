
//=====================================================================
//  TopModule
//
//  Computes three output vectors from a 4‑bit input:
//
//  1) out_both   : bit i is 1 iff in[i] and its left neighbour (i+1) are 1.
//                   out_both[3] is unused.
//
//  2) out_any    : bit i is 1 iff in[i] or its right neighbour (i‑1) are 1.
//                   out_any[0] is unused.
//
//  3) out_different : bit i is 1 iff in[i] differs from its left neighbour
//                    (wrapping around: left neighbour of in[3] is in[0]).
//=====================================================================
module TopModule (
    input  wire [3:0] in,
    output wire [2:0] out_both,
    output wire [3:1] out_any,
    output wire [3:0] out_different
);

    // (1) both neighbours to the left
    assign out_both[2] = in[2] & in[3];
    assign out_both[1] = in[1] & in[2];
    assign out_both[0] = in[0] & in[1];
    // out_both[3] is left unused – it will be 0 by default

    // (2) any neighbour to the right
    assign out_any[3] = in[3] | in[2];
    assign out_any[2] = in[2] | in[1];
    assign out_any[1] = in[1] | in[0];
    // out_any[0] is left unused – it will be 0 by default

    // (3) different from left neighbour (wrap‑around)
    assign out_different[3] = in[3] ^ in[0];
    assign out_different[2] = in[2] ^ in[3];
    assign out_different[1] = in[1] ^ in[2];
    assign out_different[0] = in[0] ^ in[1];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
