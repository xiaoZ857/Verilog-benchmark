

module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

assign Y2 = (y[5] == 0) ? y[3] : (w == 1 && y[5] == 1) ? y[6] : (w == 0 && y[5] == 1) ? y[4] : 0;
assign Y4 = (y[5] == 0) ? y[2] : (w == 1 && y[5] == 1) ? y[3] : (w == 0 && y[5] == 1) ? y[6] : 0;

// VERILOG-EVAL: endmodule not found
