
module TopModule (
  input [7:0] in,
  output parity
);
  
  // Compute the even parity bit by XOR-ing all 8 data bits
  assign parity = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];
  
endmodule

// VERILOG-EVAL: errant inclusion of module definition
