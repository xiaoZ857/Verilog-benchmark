
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output reg walk_left,
  output reg walk_right,
  output reg aaah,
  output reg digging
);

    // State encoding
    typedef enum logic [2:0] {
        WALK_LEFT = 3'b001,   // Walking left
        WALK_RIGHT = 3'b010,  // Walking right
        FALLING = 3'b011,     // Falling
        DIGGING = 3'b100      // Digging
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_right || (bump_left && bump_right)) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_left || (bump_right && bump_left)) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end

            FALLING: begin
                if (ground) begin
                    next_state = current_state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
                end else begin
                    next_state = FALLING;
                end
            end

            DIGGING: begin
                if (!ground) begin
                    next_state = FALLING;
                end else begin
                    next_state = current_state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
                end
            end

            default: begin
                next_state = WALK_LEFT; // Default to walking left on undefined state
            end
        endcase
    end

    // Output logic based on the current state
    always_comb begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1; // Explicitly cast to logic 1
            end

            WALK_RIGHT: begin
                walk_right = 1'b1; // Explicitly cast to logic 1
            end

            FALLING: begin
                aaah = 1'b1; // Explicitly cast to logic 1
            end

            DIGGING: begin
                digging = 1'b1; // Explicitly cast to logic 1
            end

            default: begin
                // Default assignments to ensure all outputs are explicitly set
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
