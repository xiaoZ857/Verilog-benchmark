
module TopModule (
  input [3:0] in,
  output reg out_and,
  output reg out_or,
  output reg out_xor
);

// Instantiate AND gate
and4 U1 (
    .A(in[3]),
    .B(in[2]),
    .C(in[1]),
    .D(in[0]),
    .Y(out_and)
);

// Instantiate OR gate
or4 U2 (
    .A(in[3]),
    .B(in[2]),
    .C(in[1]),
    .D(in[0]),
    .Y(out_or)
);

// Instantiate XOR gate
xor4 U3 (
    .A(in[3]),
    .B(in[2]),
    .C(in[1]),
    .D(in[0]),
    .Y(out_xor)
);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
