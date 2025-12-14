
module TopModule (
  input [2:0] vec,
  output [2:0] outv,
  output o2,
  output o1,
  output o0
);
// Shift the input vector to the right by one position and select the last bit
assign o2 = vec[0];

// Select the middle bit of the input vector
assign o1 = vec[1];

// Select the least significant bit of the input vector
assign o0 = vec[2];

// Output of the same vector as input
assign outv = vec;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
