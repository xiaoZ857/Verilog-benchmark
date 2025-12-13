
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
  // Internal signals
  wire xor_ab;
  wire xor_sum_cin;

  // XOR gate for a XOR b
  xor_ab = a ^ b;

  // XOR gate for (a XOR b) XOR cin
  xor_sum_cin = xor_ab ^ cin;

  // Sum is the output of the second XOR gate
  sum = xor_sum_cin;

  // Carry-out is the OR of (a AND b) and ((a XOR b) AND cin)
  cout = (a & b) | (xor_ab & cin);

endmodule
