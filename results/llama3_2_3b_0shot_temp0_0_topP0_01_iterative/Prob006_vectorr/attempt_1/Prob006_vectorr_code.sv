
// Implement the Verilog module based on the following description.
// Given an 8-bit input vector [7:0], reverse its bit ordering.

module TopModule (
  input [7:0] in,
  output [7:0] out
);

// Reverse the bit ordering of the input vector
assign out = {in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]};

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
