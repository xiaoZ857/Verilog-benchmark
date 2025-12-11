
module TopModule (
  input a,
  input b,
  input c,
  output out
);
assign out = (a & b) | (c & ~b) | (~a & c); endmodule

// VERILOG-EVAL: endmodule not found
