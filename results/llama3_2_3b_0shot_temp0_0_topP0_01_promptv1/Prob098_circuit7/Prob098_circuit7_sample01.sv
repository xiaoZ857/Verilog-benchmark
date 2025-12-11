
module TopModule (
  input clk,
  input a,
  output reg q
);
assign q = (a & ~q) ? 1'b0 : a;

// VERILOG-EVAL: endmodule not found
