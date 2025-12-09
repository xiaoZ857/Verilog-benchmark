
module TopModule (
  input x,
  input y,
  output z
);
  assign z = (x ^ y) & x;

// VERILOG-EVAL: endmodule not found
