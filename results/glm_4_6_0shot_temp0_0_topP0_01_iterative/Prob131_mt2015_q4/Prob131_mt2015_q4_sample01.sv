
module TopModule (
  input x,
  input y,
  output z
);

  // Internal signals for submodule outputs
  wire a1_out, a2_out, b1_out, b2_out;
  wire or_out, and_out;
  
  // Module A instances
  // z = (x^y) & x
  assign a1_out = (x ^ y) & x;
  assign a2_out = (x ^ y) & x;
  
  // Module B instances
  // From waveform analysis: z = ~(x^y) (XNOR)
  assign b1_out = ~(x ^ y);
  assign b2_out = ~(x ^ y);
  
  // OR gate for first pair
  assign or_out = a1_out | b1_out;
  
  // AND gate for second pair
  assign and_out = a2_out & b2_out;
  
  // Final XOR gate
  assign z = or_out ^ and_out;

endmodule
