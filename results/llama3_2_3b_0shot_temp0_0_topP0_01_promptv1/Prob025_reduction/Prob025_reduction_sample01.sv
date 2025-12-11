
module TopModule (
  input [7:0] in,
  output parity
);
assign parity = ~((in[7:1]) ^ in[0]); endmodule

// VERILOG-EVAL: endmodule not found
