
module TopModule (
  input wire in1,
  input wire in2,
  input wire in3,
  output logic out
);

// XNOR gate implementation
xnor xnor_gate (
  .in1(in1),
  .in2(in2),
  .out(xnor_out)
);

// XOR gate implementation
xor xor_gate (
  .in1(xnor_out),
  .in2(in3),
  .out(out)
);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
