
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);
// First layer AND gates
wire and1 (
  .o(and1),
  .a(a),
  .b(b)
);

wire and2 (
  .o(and2),
  .a(c),
  .b(d)
);

// Intermediate wire to connect the AND and OR gates together
wire intermed_wire (
  .o(intermed_wire),
  .i1(and1),
  .i2(and2)
);

// Second layer OR gate and inverter for out_n
or out (
  .o(out),
  .a(intermed_wire)
);
assign out_n = ~out;

endmodule
