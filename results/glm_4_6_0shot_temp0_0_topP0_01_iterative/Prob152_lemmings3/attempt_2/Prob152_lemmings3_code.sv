
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
  
  // State transition logic
  always @(*) begin
    case (state)
      WALK_LEFT: begin
        if (!ground) begin
          next_state = FALL_LEFT;
        end else if (dig) begin
          next_state = DIG_LEFT;
        end else if (bump_left || bump_right) begin
          next_state = WALK_RIGHT;
        end else begin
          next_state = WALK_LEFT;
        end
      end
      
      WALK_RIGHT: begin
        if (!ground) begin
          next_state = FALL_RIGHT;
        end else if (dig) begin
          next_state = DIG_RIGHT;
        end else if (bump_left || bump_right) begin
          next_state = WALK_LEFT;
        end else begin
          next_state = WALK_RIGHT;
        end
      end
      
      FALL_LEFT: begin
        if (ground) begin
          next_state = WALK_LEFT;
        end else begin
          next_state = FALL_LEFT;
        end
      end
      
      FALL_RIGHT: begin
        if (ground) begin
          next_state = WALK_RIGHT;
        end else begin
          next_state = FALL_RIGHT;
        end
      end
      
      DIG_LEFT: begin
        if (!ground) begin
          next_state = FALL_LEFT;
        end else begin
          next_state = DIG_LEFT;
        end
      end
      
      DIG_RIGHT: begin
        if (!ground) begin
          next_state = FALL_RIGHT;
        end else begin
          next_state = DIG_RIGHT;
        end
      end
      
      default: begin
        next_state = WALK_LEFT;
      end
    endcase
  end
  
  // State register
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
    end else begin
      state <= next_state;
    end
  end
  
  // Output logic
  assign walk_left = (state == WALK_LEFT);
  assign walk_right = (state == WALK_RIGHT);
  assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
  assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);
  
endmodule
