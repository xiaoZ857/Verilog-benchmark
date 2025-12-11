
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);
wire and_gate1, and_gate2;

assign and_gate1 = a & b;
assign and_gate2 = c & d;
assign out = and_gate1 | and_gate2;
assign out_n = ~out;

endmodule
