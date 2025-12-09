
// TopModule.v
// Two‑layer combinational logic: (a & b) | (c & d)
// with an inverted output.

module TopModule (
    input  a,
    input  b,
    input  c,
    input  d,
    output out,
    output out_n
);

    // Intermediate wires for the two AND gates
    wire w1, w2;

    // First layer – two AND gates
    and (w1, a, b);   // w1 = a & b
    and (w2, c, d);   // w2 = c & d

    // Second layer – OR gate producing the main output
    or  (out, w1, w2);   // out = w1 | w2

    // Inverted output
    not (out_n, out);    // out_n = ~out

endmodule

// VERILOG-EVAL: errant inclusion of module definition
