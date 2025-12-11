
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = (~a & ~b & ~c & d) | 
           (~a & ~b & c & d) |
           (~a & b & ~c & d) |
           (~a & b & c & ~d) |
           (a & ~b & ~c & d) |
           (a & ~b & c & ~d) |
           (a & b & ~c & 0) |
           (a & b & c & d);
endmodule
