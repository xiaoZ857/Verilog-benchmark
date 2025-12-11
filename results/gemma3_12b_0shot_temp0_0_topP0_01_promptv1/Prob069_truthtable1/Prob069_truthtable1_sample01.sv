
module TopModule (
  input x3,
  input x2,
  input x1,
  output f
);
assign f = (x3 == 1) ? ((x2 == 1) ? (x1 == 1 ? 1 : 1) : (x1 == 1 ? 1 : 0)) : (x2 == 1 ? (x1 == 1 ? 1 : 0) : 0);
endmodule
