
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output walk_left,
  output walk_right,
  output aaah,
  output digging
);
always_comb begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    // Next state logic
    case (current_state)
        WALK_LEFT: begin
            if (!ground) begin
                next_state = FALLING;
            end else if (bump_right || dig) begin
                next_state = DIGGING_RIGHT;
            end else if (bump_left) begin
                next_state = WALK_RIGHT;
            end else begin
                next_state = WALK_LEFT;
            end
        end

        WALK_RIGHT: begin
            if (!ground) begin
                next_state = FALLING;
            end else if (bump_left || dig) begin
                next_state = DIGGING_LEFT;
            end else if (bump_right) begin
                next_state = WALK_LEFT;
            end else begin
                next_state = WALK_RIGHT;
            end
        end

        FALLING: begin
            if (ground) begin
                // Explicitly cast the result of the ternary operator to state_t.
                next_state = current_state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
            end else begin
                next_state = FALLING;
            end
        end

        DIGGING_LEFT: begin
            if (!ground) begin
                next_state = FALLING;
            end else if (ground && !dig) begin
                next_state = WALK_LEFT;
            end else begin
                next_state = DIGGING_LEFT;
            end
        end

        DIGGING_RIGHT: begin
            if (!ground) begin
                next_state = FALLING;
            end else if (ground && !dig) begin
                next_state = WALK_RIGHT;
            end else begin
                next_state = DIGGING_RIGHT;
            end
        end

        default: begin
            next_state = WALK_LEFT;
        end
    endcase

    // Output logic based on current state
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

        DIGGING_LEFT: begin
            digging = 1;
        end

        DIGGING_RIGHT: begin
            digging = 1;
        end

    endcase
end

endmodule
