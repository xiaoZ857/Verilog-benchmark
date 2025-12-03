
module TopModule (
  input wire in,
  output wire out
);

assign out = !in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
