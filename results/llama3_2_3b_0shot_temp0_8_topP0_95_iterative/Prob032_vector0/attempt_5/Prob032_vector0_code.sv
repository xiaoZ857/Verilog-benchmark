
module TopModule (
  input [2:0] vec,
  output [2:0] outv,
  output o2,
  output o1,
  output o0
);
// Shift the input vector to its natural positions
assign outv = vec;

// Split the input vector into three separate 1-bit outputs
assign o2 = vec[0];

assign o1 = vec[1];

assign o0 = vec[2];

// VERILOG-EVAL: endmodule not found
