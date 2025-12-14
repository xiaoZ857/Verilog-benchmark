
module TopModule (
  input a,
  input b,
  input c,
  output out
);
assign out = (!a | !b);

// VERILOG-EVAL: endmodule not found
