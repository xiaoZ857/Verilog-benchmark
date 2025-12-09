

module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  wire [2:0] inputs;
  assign inputs = {cin, b, a};

  // Sum is the XOR of all three inputs
  assign sum = ^inputs;

  // Carry-out is generated when at least two inputs are high
  assign cout = (a & b) | (b & cin) | (cin & a);
endmodule
