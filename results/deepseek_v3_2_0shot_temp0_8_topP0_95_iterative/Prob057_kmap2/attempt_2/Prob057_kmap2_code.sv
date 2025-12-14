
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out
);
  out = (~c & ~d) | (~a & b & d) | (a & ~b & d) | (a & b & ~c) | (~b & c & ~d);
endmodule
