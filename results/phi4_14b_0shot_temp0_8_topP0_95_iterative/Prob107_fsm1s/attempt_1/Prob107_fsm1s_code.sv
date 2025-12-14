
module TopModule (
  input wire clk,
  input wire in,
  input wire reset,
  output reg out
);

  // State encoding
  typedef enum logic [1:0] {
    STATE_B = 2'b00, // Initial state B
    STATE_A = 2'b01  // State A
  } state_t;

  // Registers to hold the current and next states
  state_t current_state, next_state;

  // Moore machine output logic based on state
  always @(*) begin
    case (current_state)
      STATE_B: out = 1;
      STATE_A: out = 0;
      default: out = 1; // Default to output of state B
    endcase
  end

  // State transition and synchronous reset logic
  always @(posedge clk) begin
    if (reset) begin
      current_state <= STATE_B; // Reset to initial state B
    end else begin
      current_state <= next_state; // Transition to the next state
    end
  end

  // Next state logic based on current state and input
  always @(*) begin
    case (current_state)
      STATE_B: begin
        if (in == 0) begin
          next_state = STATE_A;
        end else begin
          next_state = STATE_B; // Stay in B for input = 1
        end
      end
      
      STATE_A: begin
        if (in == 0) begin
          next_state = STATE_B;
        end else begin
          next_state = STATE_A; // Stay in A for input = 1
        end
      end

      default: begin
        next_state = STATE_B; // Default to state B
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
