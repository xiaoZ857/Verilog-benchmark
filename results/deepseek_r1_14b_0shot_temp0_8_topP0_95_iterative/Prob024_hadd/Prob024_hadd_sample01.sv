
// timescale directive is placed outside module
`timescale 1ns/1ps

module TopModule (
  input a,
  input b,
  output sum,
  output cout
);

  // Half adder logic: sum = a XOR b, carry_out = a AND b
  assign sum = a ^ b;
  assign cout = a & b;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
