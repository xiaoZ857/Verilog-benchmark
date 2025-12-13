
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);
wire and1 = a & b;
wire and2 = c & d;
wire or_input = and1 | and2;

assign out = or_input;
assign out_n = !or_input;

endmodule
