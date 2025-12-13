
// Define the module
module TopModule (
  input clk, // Positive clock signal
  input d,   // Data to be stored in the flip-flop
  output reg q // Output of the flip-flop
);

// Create a D flip-flop using a register
reg q; // Output of the flip-flop

always @(posedge clk) begin // Clocked by the positive edge of the clock signal
  if (d == 1) begin // If the data is high, set the output to 1
    q <= 1;
  else if (d == 0) begin // If the data is low, set the output to 0
    q <= 0;
  end
end

// Initialize the flip-flop to a known state
initial begin
  q = 0; // Default value of the flip-flop
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
