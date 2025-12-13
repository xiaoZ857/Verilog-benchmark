
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);
// AND gate 4-input module definition (fixed)
module and4 (
    input a, b, c, d,
    output reg y
);

reg temp;
assign temp = a & b & c & d;
assign y = temp;

endmodule

// OR gate 4-input module definition (fixed)
module or4 (
    input a, b, c, d,
    output reg y
);

reg temp;
assign temp = a | b | c | d;
assign y = temp;

endmodule

// XOR gate 4-input module definition (fixed)
module xor4 (
    input a, b, c, d,
    output reg y
);

reg temp;
assign temp = ^(a ^ b ^ c ^ d);
assign y = temp;

endmodule

// TopModule implementation (corrected)
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
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
