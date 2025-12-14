
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
  // State encoding and initialization remain as is.
  typedef enum logic [2:0] {
    IDLE = 3'b000,
    ONE_1 = 3'b001,
    TWO_1 = 3'b010,
    THREE_1 = 3'b011,
    FOUR_1 = 3'b100,
    FIVE_1 = 3'b101,
    SIX_1 = 3'b110
  } state_t;

  // Registers to hold the current and next states.
  state_t current_state, next_state;

  // Register outputs with initial values set to zero.
  reg disc_reg, flag_reg, err_reg;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      disc_reg <= 0;   // Ensure disc is reset to 0.
      flag_reg <= 0;   // Ensure flag is reset to 0.
      err_reg <= 0;    // Ensure error signal is reset to 0.
    end else begin
      // Update current state from next_state on each clock cycle.
      current_state <= next_state;

      // Determine output logic based on the current state.
      case (current_state)
        FIVE_1: begin
          if (in == 0) begin
            disc_reg <= 1;  // Set disc to 1 when five '1's are followed by '0'.
          end else begin
            err_reg <= 1;   // Set error when six consecutive '1's occur.
          end
        end
        SIX_1: begin
          flag_reg <= 1;    // Set flag for a valid frame boundary (six '1's).
        end
        default: begin
          disc_reg <= 0;
          flag_reg <= 0;
          err_reg <= 0;
        end
      endcase
    end
  end

  always_comb begin
    // Default next state logic.
    next_state = current_state;

    case (current_state)
      IDLE: begin
        if (in == 1) begin
          next_state = ONE_1; // Move to the first '1' seen.
        end
      end
      
      ONE_1: begin
        if (in == 1) begin
          next_state = TWO_1;
        end else begin
          next_state = IDLE;
        end
      end

      TWO_1: begin
        if (in == 1) begin
          next_state = THREE_1;
        end else begin
          next_state = IDLE;
        end
      end

      THREE_1: begin
        if (in == 1) begin
          next_state = FOUR_1;
        end else begin
          next_state = IDLE;
        end
      end
      
      FOUR_1: begin
        if (in == 1) begin
          next_state = FIVE_1;
        end else begin
          next_state = IDLE;
        end
      end

      FIVE_1: begin
        if (in == 0) begin
          next_state = IDLE; // Move back to IDLE when a '0' follows five '1's.
        end else begin
          next_state = SIX_1; // Transition to error state on six consecutive '1's.
        end
      end

      SIX_1: begin
        if (in == 1) begin
          next_state = SIX_1; // Stay in the error state for seven or more '1's.
        end else begin
          next_state = IDLE;
        end
      end
    endcase
  end

  // Output assignments to ensure outputs reflect registered values.
  assign disc = disc_reg;
  assign flag = flag_reg;
  assign err = err_reg;

endmodule
