
module TopModule (
  input wire a,
  input wire b,
  output wire out
);

assign out = ~(a ^ b);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
