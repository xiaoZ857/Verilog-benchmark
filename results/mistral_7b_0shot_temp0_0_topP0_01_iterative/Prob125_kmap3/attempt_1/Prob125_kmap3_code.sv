
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);

assign out = (!a & !b) | (a & b & ~c) | (a & b & c) | (!a & b & c);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
