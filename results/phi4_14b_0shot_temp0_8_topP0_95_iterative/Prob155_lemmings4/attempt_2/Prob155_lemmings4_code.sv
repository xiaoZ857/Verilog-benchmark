
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
        fall_counter <= 6'b000000;
    end else begin
        current_state <= next_state;
        if (current_state == FALLING && !ground) begin
            aaah <= 1; // Play "aaah" while falling
            if (fall_counter < 20) begin
                fall_counter <= fall_counter + 1;
            end
        end else begin
            fall_counter <= 6'b000000;
        end
    end
end

always_comb begin
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (current_state)
        WALK_LEFT: begin
            if (!ground) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end else begin
                if (bump_right || (bump_left && bump_right)) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
        end

        WALK_RIGHT: begin
            if (!ground) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end else begin
                if (bump_left || (bump_right && bump_left)) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
        end

        FALLING: begin
            if (!ground) begin
                aaah <= 1; // Continue "aaah" while falling
                next_state = FALLING;
            end else if (fall_counter >= 20) begin
                next_state = SPLATTERED;
            end else begin
                if (current_state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
        end

        DIGGING: begin
            if (!ground) begin
                aaah <= 1; // Start "aaah" when digging falls off ground
                next_state = FALLING;
            end else begin
                next_state = (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
            end
        end

        SPLATTERED: begin
            next_state = SPLATTERED; // Remain in splattered state
        end

    default:
        next_state = WALK_LEFT;
    endcase
end

always_comb begin
    case (current_state)
        WALK_LEFT: walk_left = 1;
        WALK_RIGHT: walk_right = 1;
        DIGGING: digging = 1;
        SPLATTERED: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    endcase
end

endmodule
