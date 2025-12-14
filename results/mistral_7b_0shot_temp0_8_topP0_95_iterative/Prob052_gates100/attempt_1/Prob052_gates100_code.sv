
module TopModule (
  input [99:0] in,
  output reg out_and,
  output reg out_or,
  output reg out_xor
);

// Create instances of AND, OR, and XOR gates using built-in Verilog primitives
and_gate #(100) and_instance (
    .A(in[99:0]),
    .Y(out_and)
);

or_gate #(100) or_instance (
    .A(in[99:0]),
    .Y(out_or)
);

xor_gate #(100) xor_instance (
    .A(in[99:0]),
    .Y(out_xor)
);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
