
module TopModule (
  input in1,
  input in2,
  output logic out
);
// Create AND gate using built-in verilog gates
and gate_inst (
  .A(in1),
  .B(in2), // Changing the negation operator to directly use input in2
  .Y(out)
);

// To simulate a bubble on the in2 input, apply a high impedance state using the 'tri' keyword
wire bubble;
assign bubble = 1'bz; // 'z' means high impedance

// Connect the bubble wire to the B input of AND gate as an alternative way
and gate_inst #(.B(bubble)) ( // Parameterized AND gate with B input set to the bubble wire
  .A(in1),
  .B(bubble),
  .Y(out)
);

// VERILOG-EVAL: endmodule not found
