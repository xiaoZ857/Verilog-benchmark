
module TopModule (
  input a,
  input b,
  output out
);
// Implement the NOR gate logic
assign out = ~ (a & b);

// VERILOG-EVAL: endmodule not found
