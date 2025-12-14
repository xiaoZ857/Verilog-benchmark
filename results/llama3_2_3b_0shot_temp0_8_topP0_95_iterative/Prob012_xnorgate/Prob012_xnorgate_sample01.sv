
module TopModule (
  input a,
  input b,
  output out
);
// Always block to calculate the output of XNOR gate
always @(*)
  assign out = (a == b) ? 1 : 0;

// VERILOG-EVAL: endmodule not found
