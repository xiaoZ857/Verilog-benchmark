
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);
assign and1 = a & b;
assign and2 = c & d;
assign or_gate = and1 | and2;
assign out = or_gate;
assign out_n = ~out;
endmodule
