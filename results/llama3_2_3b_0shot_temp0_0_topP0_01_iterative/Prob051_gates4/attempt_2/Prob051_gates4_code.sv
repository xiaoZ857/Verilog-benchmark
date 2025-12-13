
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);
assign out_and = in[3] & in[2] & in[1] & in[0]; // AND operation
assign out_or = in[3] | in[2] | in[1] | in[0];  // OR operation
assign out_xor = (in[3] & in[2]) ^ (in[1] & in[0]); // Corrected XOR implementation

// VERILOG-EVAL: endmodule not found
