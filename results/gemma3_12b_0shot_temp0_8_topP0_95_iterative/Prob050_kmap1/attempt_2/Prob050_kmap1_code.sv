
module TopModule (
  input a,
  input b,
  input c,
  output out
);
assign out = (!a | (a & !b & !c));

// VERILOG-EVAL: endmodule not found
