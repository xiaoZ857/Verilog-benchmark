
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = (a == 1) ? ((b == 1) ? ((c == 1) ? ((d == 1) ? 1 : 1) : 1) : 1) : 0;
endmodule
