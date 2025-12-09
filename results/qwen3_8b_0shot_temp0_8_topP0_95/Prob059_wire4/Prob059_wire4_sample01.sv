
module TopModule (
  input a,
  input b,
  input c,
  output w,
  output x,
  output y,
  output z
);

  // Assign each output to the corresponding input
  assign w = a;
  assign x = b;
  assign y = b;
  assign z = c;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
