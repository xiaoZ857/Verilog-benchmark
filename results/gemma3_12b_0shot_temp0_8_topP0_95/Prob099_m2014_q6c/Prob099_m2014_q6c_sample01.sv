
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

  // Y2 corresponds to state B (y[2] = 1)
  assign Y2 = (y[2] == 1);

  // Y4 corresponds to state D (y[4] = 1)
  assign Y4 = (y[4] == 1);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
