
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

assign q = b ? (c ? 1'b1 : d) : a;

endmodule
