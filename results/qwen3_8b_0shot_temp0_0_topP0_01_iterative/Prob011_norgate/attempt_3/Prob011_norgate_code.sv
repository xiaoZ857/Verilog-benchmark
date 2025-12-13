
module TopModule (
  input a,
  input b,
  output out
);
assign out = ~(a | b);

// VERILOG-EVAL: endmodule not found
