
// Set simulation time scale (correctly placed at the top of the file)
`timescale 1ns / 1ps

module TopModule (
  input [2:0] in,
  output [1:0] out
);
  
  wire a, b, c;
  assign a = in[0];
  assign b = in[1];
  assign c = in[2];
  
  always @* begin
    // Calculate sum of bits (population count)
    out[0] = a ^ b ^ c;     // Least significant bit (sum modulo 2)
    out[1] = (a & b) | (a & c) | (b & c); // Most significant bit (carry-out)
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
