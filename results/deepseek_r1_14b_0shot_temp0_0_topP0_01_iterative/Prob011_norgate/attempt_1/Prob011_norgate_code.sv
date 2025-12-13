
module TopModule (
  input a,
  input b,
  output out
);
  
  // Assign the output to be the negation of (a OR b)
  assign out = ~(a | b);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
