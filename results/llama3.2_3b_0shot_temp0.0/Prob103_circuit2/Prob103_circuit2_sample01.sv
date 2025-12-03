

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

assign q = (a'1 & ~b) | (~c & d) | ((~d & c) | (b & ~a));
endmodule
