
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
);

  // State definition
  typedef enum logic [1:0] {
    WALK_LEFT = 2'b00,
    WALK_RIGHT = 2'b01,
    FALLING = 2'b10
  } state_t;

  state_t current_state, next_state;

  // Output assignments based on the current state (Moore machine)
  always_comb begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;

    case (current_state)
      WALK_LEFT: begin
        walk_left = 1;
      end
      WALK_RIGHT: begin
        walk_right = 1;
      end
      FALLING: begin
        aaah = 1;
      end
      default: begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
      end
    endcase
  end

  // State transition logic
  always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always_comb begin
    next_state = current_state; // Default: stay in the current state

    case (current_state)
      WALK_LEFT: begin
        if (bump_right) begin
          next_state = WALK_RIGHT;
        end else if (ground == 0) begin
          next_state = FALLING;
        end
      end
      WALK_RIGHT: begin
        if (bump_left) begin
          next_state = WALK_LEFT;
        end else if (ground == 0) begin
          next_state = FALLING;
        end
      end
      FALLING: begin
        if (ground == 1) begin
          next_state = current_state; // Resume walking in the previous direction
        end
      end
      default: begin
        next_state = WALK_LEFT;
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
