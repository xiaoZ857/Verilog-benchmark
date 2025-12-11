
module TopModule (
  input a,
  input b,
  output q
);
assign q = (a ^ b) ? 1'b1 : 1'b0;

// VERILOG-EVAL: endmodule not found
