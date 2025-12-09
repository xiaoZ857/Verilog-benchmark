

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

wire and1_out;
wire and2_out;
wire or_out;

and1_out = a & b;
and2_out = c & d;
or_out = and1_out | and2_out;
out = or_out;
out_n = ~out;
endmodule
