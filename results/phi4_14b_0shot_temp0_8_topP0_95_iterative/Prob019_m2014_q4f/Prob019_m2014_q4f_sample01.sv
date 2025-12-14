
module TopModule (
  input in1,
  input in2,
  output logic out
);

  // Apply NOT gate (bubble) to in2 before feeding it into the AND gate.
  wire inverted_in2;

  assign inverted_in2 = ~in2; // Inverts in2

  // Connect in1 and the inverted in2 to an AND gate
  assign out = in1 & inverted_in2; // Performs logical AND operation

endmodule

// VERILOG-EVAL: errant inclusion of module definition
