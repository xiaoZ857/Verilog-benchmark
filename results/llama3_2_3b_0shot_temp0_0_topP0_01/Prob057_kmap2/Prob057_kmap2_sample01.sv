

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out
);

assign out = (a & c) | ((~a & ~c) & (~b & d)) | ((~a & ~c) & (b & d));
endmodule
