
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
  else if (ground == 0) // Falling, say "aaah!"
    state <= 3;
  else if ((state == 1 || state == 2) && ground == 1) // Ground reappears, resume previous direction
    state <= prev_state;
  else if (bump_left && bump_right) // Bumped on both sides at the same time, switch directions
    state <= (state == 1 ? 2 : 1);
  
  prev_state <= state;
end

// Assign the current state to the output signals
assign walk_left = (state == 0);
assign walk_right = (state == 1);
assign aaah = (state == 3);

endmodule
