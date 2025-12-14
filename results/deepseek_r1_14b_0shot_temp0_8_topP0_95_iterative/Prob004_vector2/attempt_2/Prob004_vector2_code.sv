
// Set timescale at the top level of the file
`timescale 1ns / 1ps

module TopModule (
  input [31:0] in,
  output [31:0] out
);

// Reversing the byte order of a 32-bit vector
// Input is divided into four bytes, which are swapped as follows:
// byte 0 <-> byte 3 and byte 1 <-> byte 2

assign out[7:0] = in[7:0];    // Assign first byte to last position
assign out[15:8] = in[15:8];  // Assign second byte to third position
assign out[23:16] = in[23:16];// Assign third byte to second position
assign out[31:24] = in[31:24];// Assign fourth byte to first position

endmodule

// VERILOG-EVAL: errant inclusion of module definition
