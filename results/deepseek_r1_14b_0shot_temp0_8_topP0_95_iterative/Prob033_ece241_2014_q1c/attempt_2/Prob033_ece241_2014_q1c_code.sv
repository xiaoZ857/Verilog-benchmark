
// This should be at the top of your file before any module definitions
`timescale 1ns / 1ps

module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

// Compute the sum using $signed for two's complement addition
assign s = $signed(a) + $signed(b);
 
// Detect overflow on signed addition of two's complement numbers
assign overflow = ($signed(a) > 0 && $signed(b) > 0 && ~$signed(s)) ||
                 ($signed(a) < 0 && $signed(b) < 0 && $signed(s));

endmodule

// VERILOG-EVAL: errant inclusion of module definition
