
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

  typedef enum {walk_left_state, walk_right_state, fall_state} state_t;
  state_t state, next_state;

  always_ff @posedge clk or posedge areset
    if (areset) begin
      state <= walk_left_state;
    end else begin
      state <= next_state;
    end

  always_comb begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    case(state)
      walk_left_state: begin
        if (bump_left || bump_right) begin
          next_state = walk_right_state;
        end else begin
          next_state = walk_left_state;
        end
        walk_left = 1;
      end
      walk_right_state: begin
        if (bump_left || bump_right) begin
          next_state = walk_left_state;
        end else begin
          next_state = walk_right_state;
        end
        walk_right = 1;
      end
      fall_state: begin
        aaah = 1;
        if (ground == 1) begin
          next_state = (previous_direction == walk_left_state) ? walk_left_state : walk_right_state;
        end else begin
          next_state = fall_state;
        end
      end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
