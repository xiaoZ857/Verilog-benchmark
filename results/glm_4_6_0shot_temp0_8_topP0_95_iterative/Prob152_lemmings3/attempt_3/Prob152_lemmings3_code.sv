
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

// State encoding
parameter WALK_LEFT = 3'b000;
parameter WALK_RIGHT = 3'b001;
parameter FALL_LEFT = 3'b010;
parameter FALL_RIGHT = 3'b011;
parameter DIG_LEFT = 3'b100;
parameter DIG_RIGHT = 3'b101;

reg [2:0] state, next_state

// VERILOG-EVAL: endmodule not found
