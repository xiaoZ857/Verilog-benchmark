
module TopModule (
  input wire clk,
  input wire in,
  input wire areset,
  output reg out
);

  // Define states
  typedef enum logic [1:0] {
    STATE_B = 2'b01,  // State B
    STATE_A = 2'b00   // State A
  } state_t;

  // Declare the current and next state registers
  state_t current_state, next_state;

  // Moore machine output logic based on current state
  always @(*) begin
    case (current_state)
      STATE_B: out = 1;  // Output is 1 in State B
      STATE_A: out = 0;  // Output is 0 in State A
      default: out = 1'b0;
    endcase
  end

  // Next state logic based on current state and input
  always @(*) begin
    case (current_state)
      STATE_B: 
        if (in == 1'b0) next_state = STATE_A;  // Transition to A on input 0
        else            next_state = STATE_B;  // Stay in B on input 1

      STATE_A:
        if (in == 1'b0) next_state = STATE_B;  // Transition to B on input 0
        else            next_state = STATE_A;  // Stay in A on input 1

      default: next_state = STATE_B;
    endcase
  end

  // State register update with asynchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset)
      current_state <= STATE_B;  // Asynchronously reset to state B
    else
      current_state <= next_state;  // Update state on clock edge
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
