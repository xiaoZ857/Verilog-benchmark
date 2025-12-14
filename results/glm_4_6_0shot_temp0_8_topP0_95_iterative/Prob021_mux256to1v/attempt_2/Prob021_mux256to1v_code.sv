
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

// Use the 8-bit selector to choose which 4-bit group to output
// Each group is 4 bits, so multiply by 4 to get the starting position
assign out = in[sel*4 + 3 : sel*4];

endmodule
