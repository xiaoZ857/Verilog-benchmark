
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

// Moore state machine for Lemming behavior
parameter STATE_LEFT = 1'b0;
parameter STATE_RIGHT = 1'b1;

reg state, next_state;

// State register with asynchronous reset
always @(posedge clk or posedge areset) begin
  if (areset)
    state <= STATE_LEFT;
  else
    state <= next_state;
end

// Next state logic
always @(*) begin
  case (state)
    STATE_LEFT: begin
      if (bump_left)
        next_state = STATE_RIGHT;
      else
        next_state = STATE_LEFT;
    end
    STATE_RIGHT: begin
      if (bump_right)
        next_state = STATE_LEFT;
      else
        next_state = STATE_RIGHT;
    end
    default: next_state = STATE_LEFT;
  endcase
end

// Output logic (Moore machine - outputs depend only on current state)
assign walk_left = (state == STATE_LEFT);
assign walk_right = (state == STATE_RIGHT);

endmodule
