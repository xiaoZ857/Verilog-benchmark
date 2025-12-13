
// Create a module with one input and one output that behaves like a wire.
module TopModule (
  // Input signal
  input in,

  // Output signal
  output out
);

// Assign the input to the output
assign out = in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
