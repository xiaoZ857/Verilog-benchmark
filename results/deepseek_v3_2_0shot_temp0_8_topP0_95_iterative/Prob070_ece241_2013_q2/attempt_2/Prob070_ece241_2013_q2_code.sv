
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);
// SOP form: out_sop = a' b' c + a' c d + b c d
// POS form: out_pos = (a + c)(b' + c + d')(b + c' + d)
assign out_sop = (~a & ~b & c) | (~a & c & d) | (b & c & d);
assign out_pos = (a | c) & (~b | c | ~d) & (b | ~c | d);
endmodule
