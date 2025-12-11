
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = (a == 0) ? ((b == 0) ? (c | d) : 1'b1) :
           ((b == 0) ? (c | d) : 1'b1);
endmodule
