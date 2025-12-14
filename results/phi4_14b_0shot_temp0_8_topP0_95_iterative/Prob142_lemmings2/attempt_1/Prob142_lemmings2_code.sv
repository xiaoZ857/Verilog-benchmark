
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
        WALK_LEFT,      // Walking left
        WALK_RIGHT,     // Walking right
        FALLING         // Falling down
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;  // Asynchronous reset to walk left
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
                walk_left = 1;  // Walking left by default
                if (!ground) begin
                    next_state = FALLING;  // Start falling if no ground
                end else if (bump_right || (bump_left && bump_right)) begin
                    next_state = WALK_RIGHT;  // Switch to right on bump
                end else begin
                    next_state = current_state;  // Stay in the same state
                end
            end

            WALK_RIGHT: begin
                walk_right = 1;  // Walking right by default
                if (!ground) begin
                    next_state = FALLING;  // Start falling if no ground
                end else if (bump_left || (bump_right && bump_left)) begin
                    next_state = WALK_LEFT;  // Switch to left on bump
                end else begin
                    next_state = current_state;  // Stay in the same state
                end
            end

            FALLING: begin
                aaah = 1;  // "Aaah!" while falling
                if (ground) begin
                    // Resume last walking direction when ground reappears
                    if (current_state == WALK_LEFT || current_state == FALLING) begin
                        next_state = WALK_LEFT;
                    end else if (current_state == WALK_RIGHT || current_state == FALLING) begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    next_state = current_state;  // Stay falling until ground reappears
                end
            end

            default: begin
                next_state = WALK_LEFT;  // Default state is walking left
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
