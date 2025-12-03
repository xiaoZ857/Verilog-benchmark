

module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

assign out_and = ~in;
assign out_or = in;
assign out_xor = in[1:1] ^ in[2:2] ^ ... ^ in[99:99];
endmodule
