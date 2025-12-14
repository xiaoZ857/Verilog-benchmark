
module TopModule (
  input clk,      // Positive clock signal
  input j,         // Input to transition from OFF to ON state
  input k,         // Input to transition within the ON state
  input reset,     // Active-high synchronous reset
  output out       // Output of the state machine
);

wire [1:0] nextState; // Next state of the state machine

always @(posedge clk or reset) begin
  if (reset == 1) begin      // Reset active-high, resets to OFF state
    nextState <= 2'b00;
  else if (j == 1 && k == 0) begin
    nextState <= 2'b10;       // Transition from OFF to ON state
  else if (k == 1) begin        // Transition within the ON state
    nextState <= 2'b01;
  else                          // Stay in the current state
    nextState <= 2'b00;
  end
end

assign out = nextState[0];   // Output is the next state in binary format

endmodule

// VERILOG-EVAL: errant inclusion of module definition
