
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out
);
assign out = (a & d) | ((~a & ~d) | (~b & c)); endmodule

// VERILOG-EVAL: endmodule not found
