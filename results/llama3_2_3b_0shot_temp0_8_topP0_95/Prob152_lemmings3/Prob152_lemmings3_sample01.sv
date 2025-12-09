
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output walk_left,
  output walk_right,
  output aaah,
  output digging
);
module LemmingsStateMachine (
  input clk, 
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output walk_left,
  output walk_right,
  output aaah,
  output digging
);

  reg [1:0] state; // State (00 = Idle, 01 = Walking Left, 10 = Walking Right)
  reg [1:0] next_state; // Next state

  assign walk_left = (state == 2'd00) ? 0 : (state == 2'd11) ? 1 : ((bump_left && !ground) || (!digging && !falling) ? 1 : 0);
  assign walk_right = (state == 2'd01) ? 0 : (state == 2'd10) ? 1 : ((bump_right && !ground) || (!digging && !falling) ? 1 : 0);

  reg bit falling; // Falling state
  assign falling = (state == 2'd00) && ground;

  reg bit digging_state; // Digging state
  assign digging_state = (state == 2'd01) && dig && ground;

  always #(.positive clk) 
    if (falling)
      next_state = 2'd10;
    else
      next_state = (digging_state ? 2'd11 : ((bump_left && !ground) || (!digging && falling) ? 2'd01 : state));

  always #(.positive clk) 
    if (next_state != state)
      state <= next_state;

assign aaah = state == 2'd00 && ground;
assign digging = digging_state;

initially
  $resetforget(areset);
  state <= 2'd00;

endmodule
