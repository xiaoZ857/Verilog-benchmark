
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
assign out = (a & d) | (b & ~c); endmodule

// VERILOG-EVAL: endmodule not found
