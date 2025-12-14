
module TopModule (
  input x,
  input y,
  output z
);
logic intermediate1, intermediate2;
assign intermediate1 = (x & ~y);
assign intermediate2 = (~x & y);
assign z = ((~y & x) | (y & x)) & x;

endmodule
