
module TopModule (
  input [7:0] in,
  output parity
);
  // Internal signal to store the XOR result
  wire xor_result;

  // XOR the 8 data bits to calculate the parity bit
  xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
  parity = xor_result;

endmodule
