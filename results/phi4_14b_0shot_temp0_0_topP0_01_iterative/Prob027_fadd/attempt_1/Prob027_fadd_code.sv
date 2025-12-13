
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
  output cout,
  output sum
);

  // Calculate the sum bit
  assign sum = a ^ b ^ cin;

  // Calculate the carry-out bit
  assign cout = (a & b) | (b & cin) | (cin & a);

endmodule

// Top-level module to use the FullAdder
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Instantiate the FullAdder
  FullAdder fa (
    .a(a),
    .b(b),
    .cin(cin),
    .cout(cout),
    .sum(sum)
  );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
