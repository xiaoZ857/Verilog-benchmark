
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

reg [19:0] state; // The current state of the FSM (20 states, including initial and final)

always @(posedge clk or posedge areset)
begin
  if (areset)
    state <= 0; // Reset to initial state
  else if (ground == 1'b0 && state != 19) // Falling
  begin
    if (state == 0) // Initial state, start falling
      aaah <= 1'b0;
    else if ($cast(time, $ms) > 20) // Splatter if falling for too long
      state <= 19; // Final state, lemming splattered
    else
      aaah <= 1'b1; // Say "aaah!" while falling
  end
  else if (ground == 1'b1 && state != 0) // Walking or Digging
  begin
    if (dig == 1'b1 && ground[state] == 1'b1) // Digging on ground
      state <= state + 2; // Transition to next digging state
    else // Walking or switching direction
    begin
      if ((bump_left == 1'b1 && walk_right == 0'b0) || (bump_right == 1'b1 && walk_left == 0'b0)) // Switch directions on bump
        state <= state + 1; // Transition to next walking/switching state
      else if (walk_left == 1'b1 && ground[state] == 1'b0) // Reach end of left side, switch to falling
        state <= 1;
      else if (walk_right == 1'b1 && ground[state+1] == 1'b0) // Reach end of right side, switch to falling
        state <= state + 3;
    end
  end
end

always @(posedge clk)
begin
  walk_left <= (state == 0 || state == 2 || state == 4);
  walk_right <= (state == 1 || state == 3 || state == 5);
  digging <= (state >= 2 && state < 18);
  aaah <= (!ground && state != 19);
end

function int ground[index]; // Helper function to check if the current state is on ground
begin
  if (index > 0 && index < 19)
    return 1;
  else
    return 0;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
