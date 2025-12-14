
module TopModule (
  input clk,
  input reset,
  output reg shift_ena
);

  // Define states for the FSM
  typedef enum logic [1:0] {
    IDLE = 2'b00,   // Initial state
    ENABLE_SHIFT = 2'b01, // State where shift_ena is enabled
    HOLD = 2'b10    // Final state, after four cycles of enable_shift
  } state_t;

  // Registers to hold the current and next states
  state_t current_state, next_state;
  
  integer counter; // Counter for counting 4 clock cycles

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      shift_ena <= 1'b1; // Assert shift_ena during the first four cycles on reset
      counter <= 3; // Initialize counter to count down from 3
    end else begin
      current_state <= next_state;

      if (current_state == ENABLE_SHIFT) begin
        if (counter > 0) begin
          shift_ena <= 1'b1;
          counter <= counter - 1;
        end else begin
          shift_ena <= 1'b0; // Disable shift_ena after four cycles
        end
      end else begin
        shift_ena <= 1'b0;
        counter <= 3; // Reset the counter if we are not in ENABLE_SHIFT state
      end
    end
  end

  always_comb begin
    next_state = current_state;

    case (current_state)
      IDLE: begin
        // Check condition for enabling shift register, assuming a signal `pattern_detected`
        // which should be defined elsewhere or passed as an input to the module.
        if (reset || pattern_detected) begin
          next_state = ENABLE_SHIFT;
          counter <= 3; // Start counting down from 3 to enable for 4 cycles
        end
      end

      ENABLE_SHIFT: begin
        if (counter == 0) begin
          next_state = HOLD;
        end
      end
      
      HOLD: begin
        // Stay in HOLD state unless reset is detected, which will transition back to IDLE
        if (reset) begin
          next_state = IDLE;
        end
      end

      default: begin
        next_state = IDLE;
      end
    endcase
  end
  
endmodule

// VERILOG-EVAL: errant inclusion of module definition
