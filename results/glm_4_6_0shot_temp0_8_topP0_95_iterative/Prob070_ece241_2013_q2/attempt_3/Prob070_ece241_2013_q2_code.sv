
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  // Minimum Sum-of-Products implementation
  assign out_sop = (c & d) | (a & b & c);
  
  // Minimum Product-of-Sums implementation
  assign out_pos = (~a | ~c | ~d) & (~b | c) & (a | ~b | ~d | c);

endmodule
