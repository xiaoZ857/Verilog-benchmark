
// Define a module for one stage of the shift register circuit
module TopModule (
  input clk, // Positive clock signal
  input w,   // Input to the first stage of the shift register
  input R,   // Value to load into the shift register
  input E,   // Enable signal for shifting
  input L,   // Load signal
  output reg Q // Output of the shift register
);

// Instantiate a D flip-flop (DFF) for this stage
DFlipFlop #(.DWIDTH(1)) DFF (
  .clk(clk),
  .D(w),
  .Q(Q)
);

// Instantiate a multiplexer to select between the current value and the input w
Mux2 #(.WIDTH(1)) MUX (
  .A(R), // Current value of the shift register
  .B(w), // Input to the first stage of the shift register
  .sel(E), // Enable signal for shifting
  .out(Q) // Output of the multiplexer
);

// Instantiate a multiplexer to select between the current output and the load input
Mux2 #(.WIDTH(1)) MUX_L (
  .A(Q), // Current output of the shift register
  .B(L), // Load signal
  .sel(!E), // Disable signal for shifting
  .out(Q) // Output of the multiplexer
);

// Connect the outputs of the DFF and the two multiplexers to form the desired behavior
assign Q = MUX_L.out;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
