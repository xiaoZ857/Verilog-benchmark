
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);
assign Y2 = (y[5] == 0) ? y[3] : (w == 1);
assign Y4 = (y[5] == 0) ? y[4] : (w == 1);

// VERILOG-EVAL: endmodule not found
