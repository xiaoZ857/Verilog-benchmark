
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

  reg [2:0] state, next_state;
  reg [4:0] fall_counter;
  reg [4:0] next_fall_counter;
  
  localparam WALK_LEFT = 3'd0;
  localparam WALK_RIGHT = 3'd1;
  localparam FALL_LEFT = 3'd2;
  localparam FALL_RIGHT = 3'd3;
  localparam DIG_LEFT = 3'd4;
  localparam DIG_RIGHT = 3'd5;
  localparam SPLATTER = 3'd6;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
      fall_counter <= 5'd0;
    end else begin
      state <= next_state;
      fall_counter <= next_fall_counter;
    end
  end
  
  always @(*) begin
    next_state = state;
    next_fall_counter = fall_counter;
    
    case (state)
      WALK_LEFT: begin
        if (!ground) begin
          next_state = FALL_LEFT;
          next_fall_counter = 5'd0;
        end else if (dig) begin
          next_state = DIG_LEFT;
        end else if (bump_left || bump_right) begin
          next_state = WALK_RIGHT;
        end
      end
      
      WALK_RIGHT: begin
        if (!ground) begin
          next_state = FALL_RIGHT;
          next_fall_counter = 5'd0;
        end else if (dig) begin
          next_state = DIG_RIGHT;
        end else if (bump_left || bump_right) begin
          next_state = WALK_LEFT;
        end
      end
      
      FALL_LEFT: begin
        if (ground) begin
          if (fall_counter > 20) begin
            next_state = SPLATTER;
          end else begin
            next_state = WALK_LEFT;
          end
        end else begin
          next_fall_counter = fall_counter + 1;
        end
      end
      
      FALL_RIGHT: begin
        if (ground) begin
          if (fall_counter > 20) begin
            next_state = SPLATTER;
          end else begin
            next_state = WALK_RIGHT;
          end

// VERILOG-EVAL: endmodule not found
