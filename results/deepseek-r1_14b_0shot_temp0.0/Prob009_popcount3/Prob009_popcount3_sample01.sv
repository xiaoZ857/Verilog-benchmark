

module TopModule (
  input [2:0] in,
  output [1:0] out
);

// Implement a population count circuit for a 3-bit input vector
// The circuit counts the number of '1's in the input and returns a 2-bit output

wire c0, c1, c2;

// Calculate the first bit (least significant) of the count
xor c0(in[0], in[1]);
xor out[0](c0, in[2]);

// Calculate the second bit of the count using carry chain
buf c(in[0], c);
xor c(c, in[1]);
and c1(c, in[2]);
assign out[1] = c1;

endmodule
