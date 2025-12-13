
// This timescale directive sets the simulation time units to nanoseconds
`timescale 1ns / 1ps

module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  // Declare wires for intermediate signals
  wire [3:0] c;  // Carry bits for each position
  wire [3:0] s;  // Sum bits for each position

  // Full Adder instances for each bit position
  // FA_i generates the i-th bit of sum and carry
  full_adder FA_0 (
    .a(x[0]),
    .b(y[0]),
    .cin(c[0]),  // Note: c[0] is the input carry, which is 0 for LSB
    .s(s[0]),
    .cout(c[1])
  );

  full_adder FA_1 (
    .a(x[1]),
    .b(y[1]),
    .cin(c[1]),
    .s(s[1]),
    .cout(c[2])
  );

  full_adder FA_2 (
    .a(x[2]),
    .b(y[2]),
    .cin(c[2]),
    .s(s[2]),
    .cout(c[3])
  );

  full_adder FA_3 (
    .a(x[3]),
    .b(y[3]),
    .cin(c[3]),
    .s(s[3]),
    .cout(c[4])  // c[4] is the overflow bit
  );

  // Assign the sum bits and the overflow bit to the output
  assign sum[0] = s[0];
  assign sum[1] = s[1];
  assign sum[2] = s[2];
  assign sum[3] = s[3];
  assign sum[4] = c[4];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
