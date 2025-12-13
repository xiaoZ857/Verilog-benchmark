
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

// D flip-flop module
module dff (
  input clk,
  input d,
  output q
);

  reg q_reg;

  always @(posedge clk) begin
    q_reg <= d;
  end

  assign q = q_reg;

endmodule

// NOR gate module
module nor (
  input a,
  input b,
  input c,
  output z
);

  assign z = ~(a | b | c);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
