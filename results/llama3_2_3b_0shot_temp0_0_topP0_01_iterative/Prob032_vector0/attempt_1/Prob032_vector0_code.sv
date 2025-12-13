
module TopModule (
  input [2:0] vec, // 3-bit input vector
  output [2:0] outv, // same vector as input
  output o2,
  output o1,
  output o0
);

// Assign the input vector to the output vector
assign outv = vec;

// Split the input vector into three separate outputs
assign o2 = vec[0];
assign o1 = vec[1];
assign o0 = vec[2];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
