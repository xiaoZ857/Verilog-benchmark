
module TopModule (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);

    // Define the AND gate
assign out_and = in[0] & in[1] & in[2] & in[3];

    // Define the OR gate
assign out_or = in[0] | in[1] | in[2] | in[3];

    // Define the XOR gate
assign out_xor = ~(in[0] & in[1] & in[2] & in[3]) ^ (in[0] | in[1] | in[2] | in[3]);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
