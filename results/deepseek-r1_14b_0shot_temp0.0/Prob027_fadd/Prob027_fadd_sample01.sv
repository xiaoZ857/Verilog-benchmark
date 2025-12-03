

module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

// Full adder logic
assign sum = a ^ b ^ cin;
assign cout = (a & b) | ((a ^ b) & cin);
endmodule
