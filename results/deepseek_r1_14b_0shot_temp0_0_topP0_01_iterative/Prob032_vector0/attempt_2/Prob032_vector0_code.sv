
module TopModule (
  input [2:0] vec,
  output [2:0] outv,
  output o2,
  output o1,
  output o0
);

// Assign each bit of vec to individual outputs
assign o0 = vec[0];
assign o1 = vec[1];
assign o2 = vec[2];

// Output the same vector
assign outv = vec;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
