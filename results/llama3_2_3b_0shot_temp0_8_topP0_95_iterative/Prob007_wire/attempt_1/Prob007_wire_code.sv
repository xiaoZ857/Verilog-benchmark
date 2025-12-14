
// Create a module with one input and one output that behaves like a wire
module TopModule (
  // Input signal
  input clk, // Positive edge trigger clock signal
  // Output signal (acts as a wire)
  output logic out
);

// Assignation clause to make the output behave like a wire
assign out = in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
