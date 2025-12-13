
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);
// Instantiate XNOR gates
xnor xnor_gate1 (.in1(in1), .in2(in2), .out(xor_in1));
xnor xnor_gate2 (.in1(in3), .in2(!xor_in1), .out(xor_in2));

// Instantiate XOR gate
xor xor_gate (.in1(xor_in1), .in2(xor_in2), .out(out));

wire xor_in1, xor_in2;

endmodule
