
`timescale 1ns / 1ps

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

// Implementing the combinational logic based on the truth table
assign q = (~a & ~b & ~c & ~d) | 
           (a & ~b & c & ~d) |
           (~a & b & ~c & d) |
           (a & b & c & d);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
