
module TopModule (
  input x,
  input y,
  output z
);
assign z = (a1_out | b1_out) ^ (a2_out & b2_out);

wire a1_out, a2_out, b1_out, b2_out;

A a1 (
    .x(x),
    .y(y),
    .z(a1_out)
);

A a2 (
    .x(x),
    .y(y),
    .z(a2_out)
);

B b1 (
    .x(x),
    .y(y),
    .z(b1_out)
);

B b2 (
    .x(x),
    .y(y),
    .z(b2_out)
);

endmodule
