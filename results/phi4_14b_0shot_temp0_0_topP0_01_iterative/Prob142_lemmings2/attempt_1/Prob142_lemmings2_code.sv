
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output reg walk_left,
  output reg walk_right,
  output reg aaah
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,   // Walking left
        WALK_RIGHT = 2'b01,  // Walking right
        FALLING = 2'b10      // Falling
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT; // Reset to walk left
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_right || (bump_left && bump_right)) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end

                walk_left = 1;
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_left || (bump_right && bump_left)) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end

                walk_right = 1;
            end

            FALLING: begin
                if (ground) begin
                    // Resume previous direction
                    if (current_state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end else if (current_state == WALK_RIGHT) begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    next_state = FALLING;
                end

                aaah = 1; // Lemming is falling, say "aaah!"
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
