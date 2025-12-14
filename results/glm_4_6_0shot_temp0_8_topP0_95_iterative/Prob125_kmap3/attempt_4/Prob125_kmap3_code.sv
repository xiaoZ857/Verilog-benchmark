
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

always @(*) begin
  // Logic expression based on Karnaugh map
  // out = 1 when:
  // - cd = 00 and ab = 10 or ab = 11
  // - cd = 11 and ab != 01
  // - cd = 10 and ab != 01
  // For cd = 01 and ab = 10 or 11 (don't cares), choose 0
  out = (~c & ~d & a & ~b) |  // cd=00, ab=10
        (~c & ~d & a & b) |   // cd=00, ab=11
        (c & d & ((a & b) | (a & ~b) | (~a & ~b))) |  // cd=11, ab!=01
        (~c & d & ((a & b) | (a & ~b) | (~a & ~b)));  // cd=10, ab!=01
end
endmodule
