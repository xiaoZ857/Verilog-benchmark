
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = (c & ~d) | (b & ~d) | (b & c) | (a & c & ~d) | (a & b & ~d) | (a & b & c);
endmodule
