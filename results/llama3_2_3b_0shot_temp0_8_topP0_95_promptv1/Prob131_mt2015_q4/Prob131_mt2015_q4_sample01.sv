
module TopModule (
  input x,
  input y,
  output z
);
assign or = (x & x) ^ y;
assign z = or | ((~a & ~b) | (~a & b));

endmodule
