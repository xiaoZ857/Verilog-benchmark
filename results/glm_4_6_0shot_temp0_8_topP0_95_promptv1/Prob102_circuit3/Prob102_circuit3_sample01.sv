
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

assign q = (~a & ~b) ? 1'b0 : (b & (c | d)) | (~b & a & d);
endmodule
