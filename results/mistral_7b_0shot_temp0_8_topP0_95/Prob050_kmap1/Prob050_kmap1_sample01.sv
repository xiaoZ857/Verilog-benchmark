
module TopModule (
  input a,
  input b,
  input c,
  output out
);

assign out = ~a & b & c | a & ~b & c;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
