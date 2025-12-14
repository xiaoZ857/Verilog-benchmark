
module TopModule (
  input in1,
  input in2,
  output logic out
);

// Create AND gate using built-in verilog gates
and gate_inst (
  .A(in1),
  .B(!in2), // Using the negation operator (!) to simulate a bubble on the in2 input
  .Y(out)
);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
