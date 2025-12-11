
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

  // State encoding
  parameter WALK_LEFT = 1'b0;
  parameter WALK_RIGHT = 1'b1;
  
  // State register
  reg state, next_state;
  
  // State transition logic
  always @(*) begin
    case (state)
      WALK_LEFT: begin
        if (bump_left || bump_right)
          next_state = WALK_RIGHT;
        else
          next_state = WALK_LEFT;
      end
      WALK_RIGHT: begin
        if (bump_left || bump_right)
          next_state = WALK_LEFT;
        else
          next_state = WALK_RIGHT;
      end
      default: next_state = WALK_LEFT;
    endcase
  end
  
  // State register update with asynchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= WALK_LEFT;
    else
      state <= next_state;
  end
  
  // Output logic (Moore machine - outputs depend only on current state)
  assign walk_left = (state == WALK_LEFT);
  assign walk_right = (state == WALK_RIGHT);
  
endmodule
