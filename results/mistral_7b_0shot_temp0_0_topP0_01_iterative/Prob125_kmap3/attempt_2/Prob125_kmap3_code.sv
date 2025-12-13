
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
assign out = (!a & !b) | (~c & (a | b));

endmodule
