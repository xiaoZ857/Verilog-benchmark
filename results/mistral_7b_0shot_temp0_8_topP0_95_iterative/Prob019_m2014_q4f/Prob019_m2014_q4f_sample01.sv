
// Implement the Verilog module based on the following description. Assume that signals are positive clock/clk triggered unless otherwise stated.

module TopModule (
  input in1,
  input in2,
  output logic out
);

// Create AND gate using built-in verilog gates
and gate_inst (
  .A(in1),
  .B(!in2), // Changing the negation operator to directly use input in2
  .Y(out)
);

// To simulate a bubble on the in2 input, apply a high impedance state using the 'tri' keyword
wire bubble;
assign bubble = 1'btri; // 'tri' means high impedance

// Connect the bubble wire to the B input of AND gate as an alternative way (with parameterization)
and #(.B(bubble)) gate_inst2 (
  .A(in1),
  .B(bubble),
  .Y(out)
);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
