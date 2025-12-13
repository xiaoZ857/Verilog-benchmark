
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);
  assign Y1 = (y[0] == 1) ? 1 : (y[1] == 1) ? 1 : (y[5] == 1) ? 1 : (y[6] == 1) ? 1 : 0;

  assign Y3 = (y[2] == 1) ? 1 : (y[4] == 1) ? 1 : 0;

endmodule
