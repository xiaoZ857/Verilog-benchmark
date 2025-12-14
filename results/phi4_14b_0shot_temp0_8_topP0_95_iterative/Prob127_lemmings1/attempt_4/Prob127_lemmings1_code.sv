
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

// Output assignment for Moore machine based on current state
assign walk_left = (current_state == WALK_LEFT);
assign walk_right = (current_state == WALK_RIGHT);

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

// Next state logic
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

endmodule
