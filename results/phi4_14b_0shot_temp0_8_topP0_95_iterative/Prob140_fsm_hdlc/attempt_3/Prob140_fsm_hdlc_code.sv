
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
  // State encoding remains as it was.
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
  reg disc_next, flag_next, err_next; // To ensure outputs are asserted for a complete cycle.

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      disc_reg <= 0;
      flag_reg <= 0;
      err_reg <= 0;
      disc_next <= 0; // Ensure outputs are cleared on reset.
      flag_next <= 0;
      err_next <= 0;
    end else begin
      current_state <= next_state;

      // Assign to registered outputs for a complete cycle assertion.
      disc_reg <= disc_next;
      flag_reg <= flag_next;
      err_reg <= err_next;
    end
  end

  always_comb begin
    // Default next state logic and output signals.
    next_state = current_state;
    disc_next = 0;
    flag_next = 0;
    err_next = 0;

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
          disc_next = 1;     // Assert 'disc' for this cycle.
        end else begin
          next_state = SIX_1; // Transition to error state on six consecutive '1's.
          flag_next = 1;      // Assert 'flag' for this cycle.
        end
      end

      SIX_1: begin
        if (in == 1) begin
          next_state = SIX_1; // Stay in the error state for seven or more '1's.
          err_next = 1;       // Assert 'err' for this cycle.
        end else begin
          next_state = IDLE;
        end
      end
    endcase
  end

  // Output assignments to reflect registered values.
  assign disc = disc_reg;
  assign flag = flag_reg;
  assign err = err_reg;

endmodule
