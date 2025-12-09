

module TopModule (
  input [2:0] vec,
  output [2:0] outv,
  output o2,
  output o1,
  output o0
);

// Assign the input vector to the output vector
outv = vec;

// Split each bit of the input vector into individual outputs
o0 = vec[0];
o1 = vec[1];
o2 = vec[2];

endmodule
