
module TopModule (
  input x,
  input y,
  output z
);
z = 1  <=>  (x == y)
z = 0  <=>  (x != y)

// VERILOG-EVAL: endmodule not found
