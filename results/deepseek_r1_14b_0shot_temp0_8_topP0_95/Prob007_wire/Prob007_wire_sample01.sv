
module TopModule (
  input in,
  output out
);
  
  // The module simply connects the input to the output as a wire
  assign out = in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
