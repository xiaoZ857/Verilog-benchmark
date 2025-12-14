
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
// State variables
reg [1:0] state; // 2-state machine (0 - walking left, 1 - walking right)

// Timescale directive outside of module definition
`timescale 1ns / 1ps

always @(posedge clk or negedge areset) begin
    if (areset) // Asynchronous reset on positive edge of areset
        state <= 0;
    else if (bump_left && !walk_left) // Bumped left and not currently walking left
        state <= 1;
    else if (bump_right && !walk_right) // Bumped right and not currently walking right
        state <= 0;
end

always @(posedge clk) begin
    walk_left <= state[0]; // Assign the current state to walk_left
    walk_right <= state[1]; // Assign the current state to walk_right
end

// Endmodule statement added
endalways
endmodule
