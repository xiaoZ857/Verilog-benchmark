
// Finite State Machine Implementation

module TopModule(
  // Inputs
  input clk,        // Clock signal
  input reset,       // Synchronous active high reset
  input x             // Input for state transition

  // Output (Reg) and Internal Signals
  output reg [2:0] z  // Output of the FSM
);

// Internal State Variable
reg [3:0] currentState;

// Initialize State
initial begin
  currentState = 3'b000; // Initial state is 000
end

always @(posedge clk or reset) begin
  if (reset) begin // Asynchronous reset
    currentState <= 3'b000;
  else begin // Synchronous clock
    case (currentState)
      3'b000:       // State 0
        if (~x)         // If x is low
          currentState <= 3'b001; // Next state is 001
        else
          currentState <= 3'b011; // Next state is 011

      3'b001:       // State 1
        if (~x)         // If x is high
          currentState <= 3'b010; // Next state is 010
        else
          currentState <= 3'b100; // Next state is 100

      3'b010:       // State 2
        if (~x)         // If x is low
          currentState <= 3'b011; // Next state is 011
        else
          currentState <= 3'b001; // Next state is 001

      3'b011:       // State 3
        if (x == 1)      // If x is high
          currentState <= 3'b100; // Next state is 100
        else
          currentState <= 3'b001; // Next state is 001

      3'b100:       // State 4
        if (~x)         // If x is low
          currentState <= 3'b011; // Next state is 011
        else
          currentState <= 3'b100; // Next state is 100

    endcase
  end
end

// Output logic
assign z = {currentState[1:0], currentState[2]};

endmodule // TopModule

// VERILOG-EVAL: errant inclusion of module definition
