
// Set the timescale before any modules
`timescale 1ns / 1ps

module TopModule (
  input x,
  input y,
  output z
);

// Calculate XOR of x and y, then AND with x
assign z = (x ^ y) & x;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
