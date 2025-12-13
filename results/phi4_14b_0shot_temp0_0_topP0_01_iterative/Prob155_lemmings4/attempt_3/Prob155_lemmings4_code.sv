
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
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        fall_counter <= 5'b00000;
    end else begin
        current_state <= next_state;
        if (current_state == FALLING && ground) begin
            // Reset fall counter when hitting the ground after falling
            fall_counter <= 5'b00000;
        end else if (current_state == FALLING && !ground) begin
            // Increment fall counter only while falling and not on ground
            fall_counter <= fall_counter + 1;
        end
    end
end

always_comb begin
    // Default outputs
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (current_state)
        WALK_LEFT: begin
            walk_left = 1;
            if (!ground) begin
                next_state = FALLING;
            end else if (dig && fall_counter == 5'b00000) begin
                next_state = DIGGING;
            end else if ((bump_right || bump_left) && !dig) begin
                next_state = WALK_RIGHT;
            end else begin
                next_state = WALK_LEFT;
            end
        end

        WALK_RIGHT: begin
            walk_right = 1;
            if (!ground) begin
                next_state = FALLING;
            end else if (dig && fall_counter == 5'b00000) begin
                next_state = DIGGING;
            end else if ((bump_left || bump_right) && !dig) begin
                next_state = WALK_LEFT;
            end else begin
                next_state = WALK_RIGHT;
            end
        end

        FALLING: begin
            aaah = 1;
            if (fall_counter > 5'd20 && ground) begin
                // Splatter condition
                next_state = SPLITTER;
            end else if (ground) begin
                // Resume walking in the same direction after falling
                if (current_state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else if (current_state == WALK_RIGHT) begin
                    next_state = WALK_RIGHT;
                end
            end else begin
                next_state = FALLING;
            end
        end

        DIGGING: begin
            digging = 1;
            if (!ground) begin
                next_state = FALLING;
            end else begin
                // Resume walking in the original direction after digging
                if (current_state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else if (current_state == WALK_RIGHT) begin
                    next_state = WALK_RIGHT;
                end
            end
        end

        SPLITTER: begin
            // In the splattered state, all outputs are zero
            next_state = SPLITTER; // Remain in this state indefinitely
        end

        default: begin
            // Handle unexpected states by resetting to walk left
            next_state = WALK_LEFT;
        end
    endcase
end

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset outputs on asynchronous reset
        walk_left <= 0;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else if (current_state == SPLITTER) begin
        // Set all outputs to zero when splattered
        walk_left <= 0;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        // Update outputs based on current state
        case (current_state)
            WALK_LEFT: walk_left <= 1;
            WALK_RIGHT: walk_right <= 1;
            FALLING: aaah <= 1;
            DIGGING: digging <= 1;
            default: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
end

endmodule
