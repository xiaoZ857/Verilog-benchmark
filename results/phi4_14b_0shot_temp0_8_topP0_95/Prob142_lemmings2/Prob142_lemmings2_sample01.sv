
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
        WALK_LEFT = 2'b01,   // Walking left
        WALK_RIGHT = 2'b10,  // Walking right
        FALLING = 2'b11      // Falling
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= WALK_LEFT; // Asynchronous reset to walk left
        else
            current_state <= next_state;
    end

    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (current_state)
            WALK_LEFT: begin
                if (!ground) 
                    next_state = FALLING;  // Transition to falling when ground is lost
                else if (bump_right || (bump_left && bump_right))
                    next_state = WALK_RIGHT;  // Switch direction on bump
                else
                    next_state = WALK_LEFT;

                walk_left = 1;
            end

            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALLING;  // Transition to falling when ground is lost
                else if (bump_left || (bump_right && bump_left))
                    next_state = WALK_LEFT;  // Switch direction on bump
                else
                    next_state = WALK_RIGHT;

                walk_right = 1;
            end

            FALLING: begin
                aaah = 1;  // Lemming says "aaah!" while falling
                
                if (ground) 
                    if (current_state == WALK_LEFT)
                        next_state = WALK_LEFT;  // Resume walking left after fall
                    else
                        next_state = WALK_RIGHT;  // Resume walking right after fall
                else
                    next_state = FALLING;
            end
        endcase
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
