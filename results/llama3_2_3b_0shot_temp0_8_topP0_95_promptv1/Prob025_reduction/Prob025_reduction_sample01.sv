
module TopModule (
  input [7:0] in,
  output parity
);
assign parity = ~(in[2] ^ in[1] ^ in[0] ^ in[7] ^ in[6] ^ in[5] ^ in[4]);

// VERILOG-EVAL: endmodule not found
