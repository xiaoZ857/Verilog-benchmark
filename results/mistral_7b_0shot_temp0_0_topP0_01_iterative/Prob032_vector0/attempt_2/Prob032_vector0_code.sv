
module TopModule (
  input [2:0] vec,
  output [2:0] outv,
  output o2,
  output o1,
  output o0
);
always @(posedge clk) begin
  outv <= vec; // Assign the same vector to output register outv
  o0 <= vec[0]; // Assign the first bit of input vector to output o0
  o1 <= vec[1]; // Assign the second bit of input vector to output o1
  o2 <= vec[2]; // Assign the third bit of input vector to output o2
end

// Add timescale directive outside the module definition
`timescale 1ns / 1ps

// VERILOG-EVAL: endmodule not found
