
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
assign q = (r & ~q) ? 1'b0 : d;

// VERILOG-EVAL: endmodule not found
