

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

  out = (!a & !b & !c & !d) | (!a & !b & c & d) | (!a & b & c & d) | (a & b & c & d) | (a & b & !c & !d) | (a & !b & c & d) | (!a & b & c & d);
endmodule
