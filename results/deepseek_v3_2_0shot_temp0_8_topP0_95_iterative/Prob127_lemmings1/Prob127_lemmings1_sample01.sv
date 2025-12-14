
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
  // State encoding
  parameter LEFT = 1'b0;
  parameter RIGHT = 1'b1;
  
  reg state, next_state;
  
  // State register with asynchronous reset
  always @(posedge clk, posedge areset) begin
    if (areset)
      state <= LEFT;
    else
      state <= next_state;
  end
  
  // Next state logic
  always @(*) begin
    case (state)
      LEFT: next_state = bump_left ? RIGHT : LEFT;
      RIGHT: next_state = bump_right ? LEFT : RIGHT;
      default: next_state = LEFT;
    endcase
  end
  
  // Output logic (Moore style: outputs depend only on state)
  assign walk_left = (state == LEFT);
  assign walk_right = (state == RIGHT);
endmodule
