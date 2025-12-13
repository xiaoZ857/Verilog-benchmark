
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);
  assign Y1 = (y[0] == 1) ? w : 0;

  assign Y3 = (y[1] == 1) ? 1 : (y[5] == 1) ? 1 : 0;

endmodule
