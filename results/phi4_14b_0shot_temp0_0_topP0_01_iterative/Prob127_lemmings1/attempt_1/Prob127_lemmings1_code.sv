
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

  // State encoding
  typedef enum logic [1:0] {
    WALK_LEFT = 2'b00,
    WALK_RIGHT = 2'b01
  } state_t;

  // Internal state register
  state_t current_state, next_state;

  // Moore machine behavior
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always_comb begin
    case (current_state)
      WALK_LEFT: begin
        if (bump_left || bump_right) begin
          next_state = WALK_RIGHT;
        end else begin
          next_state = WALK_LEFT;
        end
      end
      
      WALK_RIGHT: begin
        if (bump_left || bump_right) begin
          next_state = WALK_LEFT;
        end else begin
          next_state = WALK_RIGHT;
        end
      end

      default: begin
        next_state = WALK_LEFT; // Default case to handle unexpected states
      end
    endcase
  end

  // Output logic based on current state (Moore machine)
  always_comb begin
    walk_left = (current_state == WALK_LEFT);
    walk_right = (current_state == WALK_RIGHT);
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
