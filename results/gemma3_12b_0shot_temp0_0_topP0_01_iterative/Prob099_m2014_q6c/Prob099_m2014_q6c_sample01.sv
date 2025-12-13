
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);
  assign Y2 = (y[1] == 1) | (y[4] == 1) | (y[6] == 1);
  assign Y4 = (y[1] == 1) | (y[2] == 1) | (y[6] == 1);

// VERILOG-EVAL: endmodule not found
