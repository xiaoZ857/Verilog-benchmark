

module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

always @(*) begin
    // Define the states of the Lemming
    assign walk_left = ~walk_right;
    
    // Determine the next state based on the current state and inputs
    case(walk_left)
        0: walk_right = bump_right; // If walking left, turn right if bumped on right
        1: walk_right = bump_left; // If walking right, turn left if bumped on left
        default: walk_right = 1;     // If both sides are bumped, stay in the same state
    endcase
    
endmodule
