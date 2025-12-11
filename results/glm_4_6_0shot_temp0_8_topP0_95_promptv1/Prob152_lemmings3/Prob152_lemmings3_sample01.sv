
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
  localparam [2:0] WALK_LEFT  = 3'b000,
                   WALK_RIGHT = 3'b001,
                   FALL_LEFT  = 3'b010,
                   FALL_RIGHT = 3'b011,
                   DIG_LEFT   = 3'b100,
                   DIG_RIGHT  = 3'b101;

  reg [2:0] state, next_state;

  // State transition logic
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= WALK_LEFT;
    else
      state <= next_state;
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
          next_state = WALK_RIGHT;
        end
      end
      
      WALK_RIGHT: begin
        if (!ground) begin
          next_state = FALL_RIGHT;
        end else if (dig) begin
          next_state = DIG_RIGHT;
        end else if (bump_left || bump_right) begin
          next_state = WALK_LEFT;
        end
      end
      
      FALL_LEFT: begin
        if (ground) begin
          next_state = WALK_LEFT;
        end
      end
      
      FALL_RIGHT: begin
        if (ground) begin
          next_state = WALK_RIGHT;
        end
      end
      
      DIG_LEFT: begin
        if (!ground) begin
          next_state = FALL_LEFT;
        end
      end
      
      DIG_RIGHT: begin
        if (!ground) begin
          next_state = FALL_RIGHT;
        end
      end
    endcase
  end

  // Output logic (Moore machine)
  assign walk_left = (state == WALK_LEFT);
  assign walk_right = (state == WALK_RIGHT);
  assign aaah = (state == FALL_LEFT || state == FALL_RIGHT);
  assign digging = (state == DIG_LEFT || state == DIG_RIGHT);

endmodule
