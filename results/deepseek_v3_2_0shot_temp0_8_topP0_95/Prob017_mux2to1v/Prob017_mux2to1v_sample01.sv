
module TopModule (
  input [99:0] a,
  input [99:0] b,
  input sel,
  output [99:0] out
);
  out = sel ? b : a;

// VERILOG-EVAL: endmodule not found
