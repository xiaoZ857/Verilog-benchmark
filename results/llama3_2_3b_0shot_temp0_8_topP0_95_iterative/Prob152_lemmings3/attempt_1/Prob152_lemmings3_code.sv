
// Lemmings finite state machine module in Verilog

module TopModule (
  // Inputs
  input clk,       // Positive edge triggered clock signal
  input areset,     // Asynchronous reset
  input bump_left,  // Left bump on the Lemming
  input bump_right, // Right bump on the Lemming
  input ground,     // Ground presence (0 = falling, 1 = walking on ground)
  input dig,        // Dig instruction

  // Outputs
  output walk_left, // Walking direction left (1 for left, 0 for right)
  output walk_right, // Walking direction right (1 for left, 0 for right)
  output aaah,      // Lemming says "aaah!"
  output digging     // Lemming is digging (1 if true, 0 if false)
);

// Define states
typedef enum logic [2:0] { 
  IDLE,           // Initial state: walking left by default
  FALLING,        // Falling on ground
  DIGGING_LEFT,   // Digging and walking left
  DIGGING_RIGHT,  // Digging and walking right
  WALKING_LEFT,    // Walking left after falling on ground
  WALKING_RIGHT,   // Walking right after falling on ground
  OBSTACLE_LEFT,   // Left obstacle bump
  OBSTACLE_RIGHT,  // Right obstacle bump
  UNKNOWN         // Unknown state (should not occur)
} states_t;

// Initialize the current state to IDLE (default walking left)
states_t cur_state = IDLE;

// Function to update and return the next state
states_t getNextState(states_t cur_state, input bump_left, input bump_right, input ground, input dig) {
  if (bump_left && !dig && !ground) {
    // Left obstacle bump while walking left or falling
    return OBSTACLE_LEFT;
  } else if (bump_right && !dig && !ground) {
    // Right obstacle bump while walking right or falling
    return OBSTACLE_RIGHT;
  } else if (!dig && ground == 0) {
    // Falling on ground
    return FALLING;
  } else if (dig && ground == 1) {
    // Digging and walking on ground
    return DIGGING_LEFT;
  } else if (dig && ground == 0) {
    // Digging while falling
    return DIGGING_RIGHT;
  } else if (ground == 1 && !dig) {
    // Walking left after falling
    if (cur_state == OBSTACLE_LEFT || cur_state == OBSTACLE_RIGHT) {
      return WALKING_LEFT;
    } else {
      return IDLE;
    }
  } else if (ground == 0 && dig) {
    // Walking right after falling
    if (cur_state == OBSTACLE_LEFT || cur_state == OBSTACLE_RIGHT) {
      return WALKING_RIGHT;
    } else {
      return DIGGING_LEFT; // Keep digging and walk left
    }
  } else {
    return UNKNOWN;
  }
}

// Logic for updating the outputs based on the current state
always_comb begin : statesLogic
  // Walking direction
  if (cur_state == IDLE || cur_state == WALKING_LEFT) {
    walk_left <= 1; walk_right <= 0;
  } else if (cur_state == WALKING_RIGHT) {
    walk_left <= 0; walk_right <= 1;
  } else {
    // No change in walking direction
    walk_left <= walk_left; walk_right <= walk_right;
  }

  // AAah!
  if ((ground == 0 && dig == 0) || (bump_left && !dig && cur_state != OBSTACLE_LEFT) ||
      (bump_right && !dig && cur_state != OBSTACLE_RIGHT)) {
    aaah <= 1; digging <= 0;
  } else {
    aaah <= 0; digging <= 1;
  }

  // Digging
  if (dig == 1 && ground == 1) {
    digging <= 1;
  }
end

// Moore state machine
always @(posedge clk or negedge areset) begin : updateState
  if (areset) {
    cur_state = IDLE;
  } else {
    states_t next_state = getNextState(cur_state, bump_left, bump_right, ground, dig);
    if (next_state != cur_state) {
      cur_state = next_state;
    }
  end
end

// Output port connections
assign walk_left = walk_left;
assign walk_right = walk_right;
assign aaah = aaah;
assign digging = digging;

endmodule // TopModule

// VERILOG-EVAL: errant inclusion of module definition
