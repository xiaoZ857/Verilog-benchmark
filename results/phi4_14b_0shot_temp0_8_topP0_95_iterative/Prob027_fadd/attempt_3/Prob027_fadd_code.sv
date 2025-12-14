
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
  output wire cout,
  output wire sum
);

  // Calculate the sum using XOR gates
  assign sum = a ^ b ^ cin;
  
  // Calculate the carry-out using AND and OR operations
  assign cout = (a & b) | ((cin) & (a ^ b));

endmodule

// Top-level module to test the FullAdder
module TopModule (
  input wire a,
  input wire b,
  input wire cin,
  output wire cout,
  output wire sum
);

  // Instantiate the FullAdder with correct port connections using '.'
  FullAdder adder (
    .a(a),
    .b(b),
    .cin(cin),
    .cout(cout),
    .sum(sum)
  );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
