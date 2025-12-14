
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

// Full adder implementation using behavioral description
assign sum = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
