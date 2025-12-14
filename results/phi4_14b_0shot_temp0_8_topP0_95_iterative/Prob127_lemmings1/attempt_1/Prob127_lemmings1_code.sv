
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

    // State encoding: 2 states, so we need only one bit.
    typedef enum logic [0:0] {
        WALK_LEFT = 1'b1,   // Lemming is walking left
        WALK_RIGHT = 1'b0   // Lemming is walking right
    } state_t;

    // Declare the current and next state variables
    state_t current_state, next_state;

    // Moore machine behavior: output depends only on the current state.
    always_comb begin
        // Default outputs to prevent latches
        walk_left = 0;
        walk_right = 0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1;   // Output is based on current state
            end
            WALK_RIGHT: begin
                walk_right = 1;  // Output is based on current state
            end
        endcase
    end

    // State transition logic and next state logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_left || bump_right) begin
                    next_state = WALK_RIGHT;  // Switch direction on a bump
                end else begin
                    next_state = WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                if (bump_left || bump_right) begin
                    next_state = WALK_LEFT;   // Switch direction on a bump
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
        endcase
    end

    // State register update with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;  // Asynchronous reset to walk left
        end else begin
            current_state <= next_state;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
