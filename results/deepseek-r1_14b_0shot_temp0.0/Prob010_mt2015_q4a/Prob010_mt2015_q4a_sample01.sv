

module TopModule (
  input x,
  input y,
  output z
);

z = (x ^ y) & x;

// VERILOG-EVAL: endmodule not found
