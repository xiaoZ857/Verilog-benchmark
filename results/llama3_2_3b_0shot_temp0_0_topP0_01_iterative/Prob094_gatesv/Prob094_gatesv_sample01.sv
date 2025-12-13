
module TopModule (
  input [3:0] in,
  output [2:0] out_both,
  output [3:1] out_any,
  output [3:0] out_different
);
assign out_both[0] = in[0] & in[1];
assign out_both[1] = in[1] & in[2];
assign out_both[2] = in[2] & in[3];

assign out_any[0] = in[0]; // select only the first bit
assign out_any[1] = in[1]; // select only the second bit
assign out_any[2] = in[2]; // select only the third bit

assign out_different[0] = in[0] ^ in[3]; // wrap around for in[3]'s neighbour
assign out_different[1] = in[1] ^ in[2];
assign out_different[2] = in[2] ^ in[0]; // wrap around for in[0]'s neighbour

// Add a timescale directive outside the module definition
timescale 1 ps / 1 ns;

endmodule
