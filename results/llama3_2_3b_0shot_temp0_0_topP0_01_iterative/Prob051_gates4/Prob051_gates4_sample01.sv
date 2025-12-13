
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);
assign out_and = in[3] & in[2] & in[1] & in[0]; // AND operation
assign out_or = in[3] | in[2] | in[1] | in[0];  // OR operation

// Corrected XOR implementation using two AND and one OR gates
assign out_xor = (in[3] & in[2]) ^ ((~in[3] & ~in[2]) | (~in[1] & ~in[0]));

// VERILOG-EVAL: endmodule not found
