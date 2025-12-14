
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
// State encoding: 2 states, so we need only one bit.
typedef enum logic [0:0] {
    WALK_LEFT = 1'b1,   // Lemming is walking left
    WALK_RIGHT = 1'b0   // Lemming is walking right
} state_t;

// Declare the current and next state variables
state_t current_state, next_state;

// State transition logic (Moore machine approach)
always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset to walk left
        current_state <= WALK_LEFT;
    end else begin
        // Update the state based on the next state logic
        current_state <= next_state;
    end
end

// Output assignment and next state logic for Moore machine
always_comb begin
    case (current_state)
        WALK_LEFT: begin
            walk_left = 1;   // Walking left in this state
            walk_right = 0;

            if (bump_left || bump_right) begin
                next_state = WALK_RIGHT;  // Switch direction on a bump
            end else begin
                next_state = WALK_LEFT;
            end
        end

        WALK_RIGHT: begin
            walk_right = 1;   // Walking right in this state
            walk_left = 0;

            if (bump_left || bump_right) begin
                next_state = WALK_LEFT;   // Switch direction on a bump
            end else begin
                next_state = WALK_RIGHT;
            end
        end

    endcase
end

endmodule
