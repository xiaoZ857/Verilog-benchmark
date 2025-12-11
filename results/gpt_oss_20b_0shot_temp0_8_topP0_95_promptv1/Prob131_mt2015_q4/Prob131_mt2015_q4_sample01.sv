
module TopModule (
  input x,
  input y,
  output z
);
wire a1_out, a2_out, b1_out, b2_out, or_out, and_out;

A u_a1 (.x(x), .y(y), .z(a1_out));
A u_a2 (.x(x), .y(y), .z(a2_out));
B u_b1 (.x(x), .y(y), .z(b1_out));
B u_b2 (.x(x), .y(y), .z(b2_out));

assign or_out = a1_out | b1_out;
assign and_out = a2_out & b2_out;
assign z = or_out ^ and_out;

endmodule
