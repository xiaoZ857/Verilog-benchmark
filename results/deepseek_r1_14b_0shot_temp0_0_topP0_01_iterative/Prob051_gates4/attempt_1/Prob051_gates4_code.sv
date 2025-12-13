
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);

// AND gate: all inputs must be 1 for output to be 1
assign out_and = in[0] & in[1] & in[2] & in[3];

// OR gate: any input being 1 results in output 1
assign out_or = in[0] | in[1] | in[2] | in[3];

// XOR gate: computed sequentially across all inputs
assign out_xor = (((in[0] ^ in[1]) ^ in[2]) ^ in[3]);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
