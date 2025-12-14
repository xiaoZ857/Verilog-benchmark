
// timescale directive should be placed outside of any module
`timescale 1ns / 1ps

module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

wire w1, w2;

// Implement full adder logic using two half-adders
assign w1 = (a ^ b) & ~cin;  // First AND gate for carry-out
assign w2 = (a ^ b) | ( (~a & cin) ) | (b & cin);  // Sum calculation

assign sum = a ^ b ^ cin;  // Final XOR for sum
assign cout = w1 | w2;    // Carry-out is combination of intermediate carries

endmodule

// VERILOG-EVAL: errant inclusion of module definition
