
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);

  // Assign sum as XOR of a and b
  assign sum = a ^ b;

  // Assign carry-out as AND of a and b
  assign cout = a & b;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
