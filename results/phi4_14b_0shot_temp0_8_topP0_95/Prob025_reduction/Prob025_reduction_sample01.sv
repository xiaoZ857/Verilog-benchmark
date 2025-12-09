
module TopModule (
    input [7:0] in,
    output parity
);

  // Compute the even parity by chaining XOR operations over all 8 input bits.
  assign parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
