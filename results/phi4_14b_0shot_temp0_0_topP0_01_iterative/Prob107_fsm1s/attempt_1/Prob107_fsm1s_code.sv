
module TopModule (
  input wire clk,
  input wire in,
  input wire reset,
  output reg out
);

  // State encoding
  typedef enum logic [1:0] {
    STATE_B = 2'b00,  // Reset state
    STATE_A = 2'b01   // Other state
  } state_t;

  // Declare the current and next state registers
  state_t current_state, next_state;

  // State transition logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= STATE_B;  // Synchronous active-high reset to state B
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always_comb begin
    case (current_state)
      STATE_B: begin
        if (in == 0) begin
          next_state = STATE_A;  // Transition to A on input 0
        end else begin
          next_state = STATE_B;  // Remain in B on input 1
        end
      end

      STATE_A: begin
        if (in == 0) begin
          next_state = STATE_B;  // Transition to B on input 0
        end else begin
          next_state = STATE_A;  // Remain in A on input 1
        end
      end

      default: begin
        next_state = STATE_B;  // Default case, go to state B
      end
    endcase
  end

  // Output logic based on current state (Moore machine)
  always_comb begin
    case (current_state)
      STATE_B: out = 1'b1;
      STATE_A: out = 1'b0;
      default: out = 1'b1;  // Default output is 1
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
