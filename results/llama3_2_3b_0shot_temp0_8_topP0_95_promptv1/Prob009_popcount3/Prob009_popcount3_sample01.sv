
module TopModule (
  input [2:0] in,
  output [1:0] out
);
assign out = $xor(in[2], in[1]) & $xor(in[1], in[0]);
endmodule
