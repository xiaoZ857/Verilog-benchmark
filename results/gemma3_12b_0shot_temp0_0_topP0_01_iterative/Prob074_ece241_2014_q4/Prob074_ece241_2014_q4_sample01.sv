
module TopModule (
  input clk,
  input x,
  output z
);
  // Internal signals for flip-flop outputs
  wire ff1_out, ff2_out, ff3_out;

  // Flip-flops
  dff ff1 (
    .clk(clk),
    .d(x ^ ff1_out),
    .q(ff1_out)
  );

  dff ff2 (
    .clk(clk),
    .d(x & ~ff2_out),
    .q(ff2_out)
  );

  dff ff3 (
    .clk(clk),
    .d(x | ~ff3_out),
    .q(ff3_out)
  );

  // NOR gate for Z
  nor nor_gate (
    .a(ff1_out),
    .b(ff2_out),
    .c(ff3_out),
    .z(z)
  );

endmodule
