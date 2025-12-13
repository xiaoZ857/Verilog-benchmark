
module TopModule (
  input [2:0] vec,
  output reg [2:0] outv,
  output reg o2,
  output reg o1,
  output reg o0
);

always @(posedge clk) begin
  outv <= vec; // Assign the same vector to output register outv
  o0 <= vec[0]; // Assign the first bit of input vector to output o0
  o1 <= vec[1]; // Assign the second bit of input vector to output o1
  o2 <= vec[2]; // Assign the third bit of input vector to output o2
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
