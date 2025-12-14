
module TopModule (
  input wire in1,
  input wire in2,
  input wire in3,
  output logic out
);

// Instantiate two XNOR gates and an XOR gate
xnor xnor_gate1 (.in1(in1), .in2(in2), .out(xor_gate1_in1));
xnor xnor_gate2 (.in1(xor_gate1_in1), .in2(in3), .out(xor_gate2_in1));
xor xor_gate (.a(xor_gate2_in1), .b(xor_gate2_in2), .out(out));

// Assign internal signal xor_gate2_in2 to be always 1 for the XOR gate
assign xor_gate2_in2 = 1'b1;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
