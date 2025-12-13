
module TopModule (
  input x3,
  input x2,
  input x1,
  output f
);
assign f = (x1 | x3);

// VERILOG-EVAL: endmodule not found
