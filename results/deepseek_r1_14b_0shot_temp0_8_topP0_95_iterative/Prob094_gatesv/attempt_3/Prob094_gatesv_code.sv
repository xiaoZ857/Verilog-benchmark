
// Set the timescale at the beginning of the file (not inside a module)
`timescale 1ns / 1ps

module TopModule (
  input [3:0] in,
  output [2:0] out_both,
  output [3:1] out_any,
  output [3:0] out_different
);

// Implement the logic for each output
assign out_both[0] = (in[0] & in[1]);          // Both bits and their left neighbor (with wrap-around)
assign out_both[1] = (in[1] & in[2]);
assign out_both[2] = (in[2] & in[3]);

assign out_any[1] = (in[1] | in[0]);           // Any bit or its right neighbor
assign out_any[2] = (in[2] | in[1]);
assign out_any[3] = (in[3] | in[2]);

assign out_different[0] = (in[0] != in[1]);    // Check if different from left neighbor (with wrap-around)
assign out_different[1] = (in[1] != in[2]);
assign out_different[2] = (in[2] != in[3]);
assign out_different[3] = (in[3] != in[0]);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
