
// Define timescale outside the module
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

  // State definition
  parameter WALK_LEFT = 0;
  parameter WALK_RIGHT = 1;

  reg current_state;

  always @(posedge clk or areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
    end else begin
      if (bump_left || bump_right) begin
        // If bumped on either side, switch direction
        current_state <= (current_state == WALK_LEFT) ? WALK_RIGHT : WALK_LEFT;
      end
    end
  end

  always @(*) begin
    walk_left = (current_state == WALK_LEFT);
    walk_right = (current_state == WALK_RIGHT);
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
