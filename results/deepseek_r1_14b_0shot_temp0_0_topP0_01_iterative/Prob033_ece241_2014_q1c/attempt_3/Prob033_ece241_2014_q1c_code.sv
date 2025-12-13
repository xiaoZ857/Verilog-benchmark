
// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.
// Assume that you have two 8-bit 2's complement numbers, a[7:0] and b[7:0].
// These numbers are added to produce s[7:0]. Also compute whether a
// (signed) overflow has occurred.

module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

  // Calculate the sum of a and b
  assign s = a + b;

  // Detect signed overflow
  wire c_in, c_out;
  assign c_in = (~a[7] & ~b[7]) | (a[7] & b[7]);  // Carry into MSB
  assign c_out = ~(~a[7] & ~b[7]) & (a[7] ^ b[7]);  // Carry out of MSB
  assign overflow = c_in ^ c_out;  // Overflow occurs when carry-in and carry-out differ

endmodule

// VERILOG-EVAL: errant inclusion of module definition
