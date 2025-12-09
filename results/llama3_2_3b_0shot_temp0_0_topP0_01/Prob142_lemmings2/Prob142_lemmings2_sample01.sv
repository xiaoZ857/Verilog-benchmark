

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

always @(*) begin
    // Lemming's state machine
    // States: walking left, walking right, falling
    
    // Initialize states
    reg [1:0] state = 2'b10; // initial state is walking left
    
    // State transitions
    case(state)
        2'b10: // walking left
            if (bump_left) state = 2'b11; // bump on the left, switch to walking right
            else if (ground == 0) state = 2'b00; // ground is 0, fall
            else if (bump_right) state = 2'b10; // bump on the right, switch back to walking left
        2'b11: // walking right
            if (bump_left) state = 2'b01; // bump on the left, switch to walking left
            else if (ground == 0) state = 2'b00; // ground is 0, fall
            else if (bump_right) state = 2'b11; // bump on the right, switch back to walking right
        2'b00: // falling
            if (ground == 1) state = 2'b10; // ground reappears, resume walking left
            else if (bump_left || bump_right) state = 2'b01; // bump while falling, switch direction
    endcase
    
    // Output logic
    walk_left = (state == 2'b10);
    walk_right = (state == 2'b11);
    aaah = (state == 2'b00); // only true when falling
    
endmodule
