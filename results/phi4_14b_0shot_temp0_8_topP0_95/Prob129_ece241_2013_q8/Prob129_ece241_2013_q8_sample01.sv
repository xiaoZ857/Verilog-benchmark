
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  // Define state encoding
  typedef enum logic [1:0] {
    IDLE = 2'b00,   // Initial state, waiting for '1'
    S1 = 2'b01,     // State after detecting '1', waiting for '0'
    S10 = 2'b10     // State after detecting '10', waiting for another '1' to complete "101"
  } state_t;

  // Declare the current and next states
  state_t current_state, next_state;

  // Sequential logic for state transition
  always_ff @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  // Combinational logic for determining the next state and output
  always_comb begin
    z = 1'b0; // Default value for output
    
    case (current_state)
      IDLE: begin
        if (x) begin
          next_state = S1;
        end else begin
          next_state = IDLE;
        end
      end
      
      S1: begin
        if (!x) begin
          next_state = S10;
        end else begin
          next_state = S1; // Stay in S1 for consecutive '1's
        end
      end
      
      S10: begin
        if (x) begin
          z = 1'b1; // Sequence "101" detected
          next_state = S1; // Go back to state S1 for potential overlap
        end else begin
          next_state = IDLE; // Reset on '0'
        end
      end
      
      default: begin
        next_state = IDLE;
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
