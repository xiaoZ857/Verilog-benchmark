
// Define the module
module TopModule (
  // Input signals
  input clk,  // Positive clock signal
  input d,    // Data to be stored in the flip-flop
  input r,    // Reset signal (active high)
  output logic q  // Output of the flip-flop
);

// Define the internal variables
logic q_next;  // Next state of the flip-flop

// D Flip-Flop Logic
always @(posedge clk) begin
  if (!r) begin  // If reset is active high, set to 0
    q_next <= 0;
  else begin  // Otherwise, update next state based on current data and previous state
    q_next <= d;
  end
end

// Assign the output of the flip-flop
assign q = q_next;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
