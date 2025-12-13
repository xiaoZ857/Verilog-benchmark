
module TopModule (
  input wire in,
  output wire out
);

  // Implementing a NOT gate using an assignment statement
  assign out = ~in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
