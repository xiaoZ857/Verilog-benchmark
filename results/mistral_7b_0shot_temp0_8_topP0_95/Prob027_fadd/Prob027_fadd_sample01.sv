
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
module FullAdder (
  input a,
  input b,
  input cin,
  output reg cout,
  output reg sum
);

// Internal signals for carry calculation and sum calculation
wire internal carry_in_sum;
wire internal carry_xor;
wire internal sum_ab;

// XOR gate for carry calculation (cin XOR a XOR b)
XOR XOR1 (
  .a(cin),
  .b(a),
  .y(carry_in_sum)
);

// XOR gate for sum calculation (a XOR b XOR cin)
XOR XOR2 (
  .a(a),
  .b(b),
  .y(carry_xor)
);

// AND gate for carry calculation (a and b)
AND AND1 (
  .a(a),
  .b(b),
  .y(sum_ab)
);

OR OR1 (
  .a(cin + carry_in_sum), // OR of cin and carry-in from XOR gate
  .b(sum_ab), // OR of a and b from AND gate
  .y(cout) // Carry-out
);

XOR XOR3 (
  .a(cin + a), // OR of cin, a from sum gate and carry-in from XOR gate
  .b(b + carry_xor), // OR of b and xor from XOR gate
  .y(sum) // Sum output
);

endmodule
