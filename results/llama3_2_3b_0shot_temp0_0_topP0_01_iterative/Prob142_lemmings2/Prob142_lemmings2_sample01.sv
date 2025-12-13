
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
);
reg [1:0] state; // State of the Lemming (00 = walking left, 01 = walking right)
reg [1:0] prev_state; // Previous state of the Lemming

// Initialize the state to walking left when areset is asserted
always @(posedge areset) begin
  state <= 0;
end

// Update the state based on the current inputs and previous state
always @(posedge clk or bump_left or bump_right or ground) begin
  if (state == 1 && !prev_state[1]) // Bumped on left, switch to walking right
    state <= 2;
  else if (state == 0 && !prev_state[0]) // Bumped on right, switch to walking left
    state <= 1;
  
  // Falling condition
  if (!ground) begin
    if ((state == 1 || state == 2) && prev_state != state) // Ground reappears while falling
      state <= prev_state;
    else if (bump_left && bump_right) // Bumped on both sides at the same time, switch directions
      state <= (state == 1 ? 2 : 1);
    else if (!prev_state[0] || !prev_state[1]) // Falling and no previous direction
      state <= 3;
  end
  
  // Ground reappearing condition
  if (ground) begin
    if ((state == 1 || state == 2) && prev_state != state) // Ground disappears while walking
      state <= prev_state;
    else if (!prev_state[0] || !prev_state[1]) // Ground appears and no previous direction
      state <= 3;
  end
  
  // Bumped on both sides at the same time, switch directions
  if (bump_left && bump_right) 
    state <= (state == 1 ? 2 : 1);
  
  prev_state <= state;
end

// Assign the current state to the output signals
assign walk_left = (state == 0);
assign walk_right = (state == 1);
assign aaah = (state == 3);

endmodule
