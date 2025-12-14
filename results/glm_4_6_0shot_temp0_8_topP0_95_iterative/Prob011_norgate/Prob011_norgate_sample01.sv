
module TopModule (
  input a,
  input b,
  output out
);

  // Implement NOR gate using logical operators
  // NOR is the complement of OR operation
  assign out = ~(a | b);

endmodule
