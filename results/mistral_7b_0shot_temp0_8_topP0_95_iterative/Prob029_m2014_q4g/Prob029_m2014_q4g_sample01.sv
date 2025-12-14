
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);
// Instantiate two XNOR gates and an XOR gate with proper port names
xnor xor_gate1 (.in1(in1), .in2(in2), .out(xor_gate1_out));
xnor xor_gate2 (.in1(xor_gate1_out), .in2(in3), .out(xor_gate2_out));
xor xor_gate (.a(xor_gate2_out), .b(1'b1), .out(out)); // The second input of the XOR is always set to 1

endmodule
