
module TopModule (
  input x,
  input y,
  output z
);
wire out_A1, out_B1, out_A2, out_B2;
wire or_out, and_out;

// Module A: z = (x^y) & x
assign out_A1 = (x ^ y) & x;
assign out_A2 = (x ^ y) & x;

// Module B: From waveform, z = ~(x | y) ? 1 : (x & y) ? 1 : 0
// Truth table from waveform:
// x y z
// 0 0 1
// 0 1 0
// 1 0 0
// 1 1 1
// So z = ~x & ~y | x & y = x ~^ y = x XNOR y
assign out_B1 = ~(x ^ y);
assign out_B2 = ~(x ^ y);

assign or_out = out_A1 | out_B1;
assign and_out = out_A2 & out_B2;
assign z = or_out ^ and_out;

endmodule
