
module TopModule (
  input a,
  input b,
  input sel,
  output out
);
assign out = sel ? a : b;

// VERILOG-EVAL: endmodule not found
