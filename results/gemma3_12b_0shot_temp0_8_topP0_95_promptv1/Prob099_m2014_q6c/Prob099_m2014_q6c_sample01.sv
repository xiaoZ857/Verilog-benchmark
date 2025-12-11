
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);
assign Y2 = (y[2] == 1'b0) ? (y[1] == 1'b1) : (y[2] == 1'b1);
assign Y4 = (y[4] == 1'b0) ? (y[4] == 1'b1) : (y[4] == 1'b1);
endmodule
