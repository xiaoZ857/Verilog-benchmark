
module TopModule(
  input clk,
  input d,
  input r,
  output logic q
);

logic q_next;

always_comb {
  q_next = (r == 1) ? 0 : ((d == 1) && !(clk == 1));
}

assign q = q_next;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
