
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
always_comb {
  assign q = ((r == 1) ? 0 : ((d == 1) && !clk));
}

// VERILOG-EVAL: endmodule not found
