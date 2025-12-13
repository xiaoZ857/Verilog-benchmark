
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
);
// Compare two 2-bit inputs and output 1 if they are equal, 0 otherwise
assign z = (A == B);
endmodule
