
module TopModule (
  input in,
  output out
);
  // Directly connect the input to the output without any processing
  assign out = in;
endmodule

// VERILOG-EVAL: errant inclusion of module definition
