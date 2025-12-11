
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  // SOP form: out_sop = a'b'c + bcd + acd
  assign out_sop = (~a & ~b & c) | (b & c & d) | (a & c & d);
  
  // POS form: out_pos = (a + c)(b + c)(c)(d)
  assign out_pos = (a | c) & (b | c) & c & d;
  
endmodule
