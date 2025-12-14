
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

reg [2:0] state, next_state;

// State transition logic
always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= WALK_LEFT;
  end else begin
    state <= next_state;
  end
end

// Next state logic
always @(*) begin
  case (state)
    WALK_LEFT: begin
      if (ground == 0) begin
        next_state = FALL_LEFT;
      end else if (dig == 1) begin
        next_state = DIG_LEFT;
      end else if (bump_left == 1 || bump_right == 1) begin
        next_state = WALK_RIGHT;
      end else begin
        next_state = WALK_LEFT;
      end
    end
    
    WALK_RIGHT: begin
      if (ground == 0) begin
        next_state = FALL_RIGHT;
      end else if (dig == 1) begin
        next_state = DIG_RIGHT;
      end else if (bump_left == 1 || bump_right == 1) begin
        next_state = WALK_LEFT;
      end else begin
        next_state = WALK_RIGHT;
      end
    end
    
    FALL_LEFT: begin
      if (ground == 1) begin
        next_state = WALK_LEFT;
     

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
