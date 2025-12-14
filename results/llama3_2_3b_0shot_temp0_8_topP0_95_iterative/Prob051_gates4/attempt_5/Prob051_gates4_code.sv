
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);
out_and = ~(a & b) | in[3];

// VERILOG-EVAL: endmodule not found
