
module TopModule (
  input x,
  input y,
  output z
);

  // Internal wires for submodule outputs
  wire a1_out, a2_out, b1_out, b2_out;
  wire or_out, and_out;
  
  // Module A: z = (x^y) & x
  assign a1_out = (x ^ y) & x;
  assign a2_out = (x ^ y) & x;
  
  // Module B: z = ~(x^y) (XNOR function based on waveform)
  assign b1_out = ~(x ^ y);
  assign b2_out = ~(x ^ y);
  
  // OR gate for first pair (A1 and B1)
  assign or_out = a1_out | b1_out;
  
  // AND gate for second pair (A2 and B2)
  assign and_out = a2_out & b2_out;
  
  // Final XOR gate
  assign z = or_out ^ and_out;
  
endmodule
