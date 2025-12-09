
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);
module HalfAdder (
  input a,
  input b,
  output sum,
  output cout
);

  // Sum is calculated as the XOR of inputs a and b.
  assign sum = a ^ b;

  // Carry-out is calculated as the AND of inputs a and b.
  assign cout = a & b;

endmodule

// Top level module for testing or integration purposes
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);

  // Instantiate the HalfAdder within the TopModule
  HalfAdder ha (
    .a(a),
    .b(b),
    .sum(sum),
    .cout(cout)
  );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
