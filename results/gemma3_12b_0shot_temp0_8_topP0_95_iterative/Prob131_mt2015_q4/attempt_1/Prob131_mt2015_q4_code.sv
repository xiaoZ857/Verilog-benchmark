
module TopModule (
  input x,
  input y,
  output z
);
module A (
  input x,
  input y,
  output z
);
  assign z = (x ^ y) & x;
endmodule

module B (
  input x,
  input y,
  output z
);
  reg z_reg;
  initial begin
    z_reg = 1;
  end
  always @(x or y) begin
    if (x == 0 && y == 0) begin
      z_reg = 1;
    end else if (x == 1 && y == 0) begin
      z_reg = 0;
    end else if (x == 0 && y == 1) begin
      z_reg = 0;
    end else if (x == 1 && y == 1) begin
      z_reg = 1;
    end else if (x == 0 && y == 0) begin
      z_reg = 1;
    end else if (x == 0 && y == 1) begin
      z_reg = 0;
    end else if (x == 0 && y == 1) begin
        z_reg = 0;
    end else if (x == 0 && y == 0) begin
        z_reg = 1;
    end else if (x == 0 && y == 1) begin
        z_reg = 0;
    end else if (x == 0 && y == 0) begin
        z_reg = 1;
    end else if (x == 0 && y == 1) begin
        z_reg = 0;
    end
    
    $display("time=%t x=%b y=%b z=%b", $time, x, y, z_reg);
    z = z_reg;
  end
endmodule

module TopModule (
  input x,
  input y,
  output z
);

  wire a_out1, b_out1, a_out2, b_out2;

  // Instantiate submodules A and B
  A a1 (
    .x(x),
    .y(y),
    .z(a_out1)
  );

  B b1 (
    .x(x),
    .y(y),
    .z(b_out1)
  );

  A a2 (
    .x(x),
    .y(y),
    .z(a_out2)
  );

  B b2 (
    .x(x),
    .y(y),
    .z(b_out2)
  );

  // Connect outputs to OR and AND gates
  wire or_out;
  wire and_out;

  or_out = a_out1 | b_out1;
  and_out = a_out2 & b_out2;

  // Connect OR and AND outputs to XOR gate
  assign z = or_out ^ and_out;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
