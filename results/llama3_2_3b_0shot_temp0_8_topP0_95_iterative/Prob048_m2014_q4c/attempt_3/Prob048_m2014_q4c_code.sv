
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
assign q = !r ? d : q;
always_comb {
  assign q = ((r == 1) ? 0 : (d && !clk));
}

// VERILOG-EVAL: endmodule not found
