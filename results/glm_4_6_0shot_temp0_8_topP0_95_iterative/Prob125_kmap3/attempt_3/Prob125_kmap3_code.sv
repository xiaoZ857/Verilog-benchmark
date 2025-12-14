
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

always @(*) begin
  // Simplified logic expression based on Karnaugh map analysis
  // out = 1 when:
  // - cd = 11 and ab != 01
  // - cd = 10 and ab != 01
  // - cd = 00 and ab = 10 or ab = 11
  out = (c & d & ((a & ~b) | (a & b) | (~a & ~b))) |  // cd=11, ab!=01
        (~c & d & ((a & ~b) | (a & b) | (~a & ~b))) |  // cd=10, ab!=01
        (~c & ~d & (a & ~b)) |  // cd=00, ab=10
        (~c & ~d & (a & b)) |  // cd=00, ab=11
        (~a & b & c & ~d) |   // cd=01, ab=01 (choose 0 for don't care)
        (a & ~b & c & ~d) |   // cd=01, ab=10 (choose 1 for don't care)
        (a & b & c & ~d) |    // cd=01, ab=11 (choose 1 for don't care)
        (~a & ~b & c & d) |   // cd=11, ab=00
        (~a & ~b & ~c & d);   // cd=10, ab=00
end
endmodule
