
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
assign out = (a & ~c) | (~b & ~d); endmodule

// VERILOG-EVAL: endmodule not found
