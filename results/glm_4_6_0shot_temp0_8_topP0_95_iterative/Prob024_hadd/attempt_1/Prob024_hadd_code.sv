
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);

  // Sum is the XOR of the inputs
  assign sum = a ^ b;

  // Carry-out is the AND of the inputs
  assign cout = a & b;

endmodule
