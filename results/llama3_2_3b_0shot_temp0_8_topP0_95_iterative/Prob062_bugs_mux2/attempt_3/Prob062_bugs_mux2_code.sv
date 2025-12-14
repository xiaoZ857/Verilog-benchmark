
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
assign out = (~sel & a) | (sel & b);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
