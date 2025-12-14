
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
  // State definitions
  parameter WALK_LEFT = 3'd0;
  parameter WALK_RIGHT = 3'd1;
  parameter FALL_LEFT = 3'd2;
  parameter FALL_RIGHT = 3'd3;
  parameter DIG_LEFT = 3'd4;
  parameter DIG_RIGHT = 3'd5;
  parameter SPLATTER = 3'd6;
  
  reg [2:0] state, next_state;
  reg [4:0] fall_counter; // Count fall cycles (up to 31, need >20)
  
  // State register
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
      fall_counter <= 5'd0;
    end else begin
      state <= next_state;
      if (state == FALL_LEFT || state == FALL_RIGHT) begin
        if (ground) begin
          fall_counter <= 5'd0; // Reset counter when hitting ground
        end else begin
          fall_counter <= fall_counter + 5'd1; // Increment while falling
        end
      end else begin
        fall_counter <= 5'd0; // Reset when not falling
      end
    end
  end
  
  // Next state logic
  always @(*) begin
    next_state = state;
    
    case (state)
      WALK_LEFT: begin
        if (!ground) begin
          next_state = FALL_LEFT;
        end else if (dig) begin
          next_state = DIG_LEFT;
        end else if (bump_left || bump_right) begin
          if (bump_right) next_state = WALK_LEFT;
          else next_state = WALK_RIGHT;
        end
      end
      
      WALK_RIGHT: begin
        if (!ground) begin
          next_state = FALL_RIGHT;
        end else if (dig) begin
          next_state = DIG_RIGHT;
        end else if (bump_left || bump_right) begin
          if (bump_left) next_state = WALK_RIGHT;
          else next_state = WALK_LEFT;
        end
      end
      
      FALL_LEFT: begin
        if (ground) begin
          if (fall_counter > 5'd20) begin
            next_state = SPLATTER;
          end else begin
            next_state = WALK_LEFT;
          end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
