
// Define a module named TopModule with inputs and outputs
module TopModule (
  // Input signals
  input in1, 
  input in2, 
  input in3,
  
  // Output signal
  output logic out
);

// Implement the XNOR gate using XOR gates
assign out = !((in1 & in2) | (in3));

endmodule

// VERILOG-EVAL: errant inclusion of module definition
