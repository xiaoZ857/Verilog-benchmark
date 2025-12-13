
// Timescale directive should be placed outside of any module
`timescale 1ns / 1ps

module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

always_comb begin
  // Calculate the starting index for the selected 4-bit segment
  integer start;
  start = (sel + 1) * 4 - 1;
  
  // Assign the corresponding 4 bits to the output
  out = in[start : start - 3];
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
