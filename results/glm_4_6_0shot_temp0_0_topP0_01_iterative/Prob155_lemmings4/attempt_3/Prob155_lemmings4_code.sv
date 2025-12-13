
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
reg current_direction;

parameter WALK_LEFT = 3'b000;
parameter WALK_RIGHT = 3'b001;
parameter FALLING = 3'b010;
parameter DIGGING = 3'b011;
parameter SPLATTERED = 3'b100;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= WALK_LEFT;
    fall_counter <= 5'b0;
    current_direction <= 1'b0;
  end else begin
    state <= next_state;
    if (state == FALLING && next_state != FALLING) begin
      fall_counter <= 5'b0;
    end else if (state == FALLING) begin
      fall_counter <= fall_counter + 1;
    end
    if ((state == WALK_LEFT || state == WALK_RIGHT) && next_state != FALLING && next_state != DIGGING) begin
      if (bump_left) current_direction <= 1'b1;
      else if (bump_right) current_direction <= 1'b0;
    end
  end
end

always @(*) begin
  next_state = state;
  case (state)
    WALK_LEFT: begin
      if (!ground) begin
        next_state = FALLING;
      end else if (dig) begin
        next_state = DIGGING;
      end else if (bump_left || bump_right) begin
        next_state = WALK_RIGHT;
      end
    end
    
    WALK_RIGHT: begin
      if (!ground) begin
        next_state = FALLING;
      end else if (dig) begin
        next_state = DIGGING;
      end else if (bump_left || bump_right) begin
        next_state = WALK_LEFT;
      end
    end
    
    FALLING: begin
      if (ground) begin
        if (fall_counter > 20) begin
          next_state = SPLATTERED;
        end else if (current_direction == 1'b0) begin
          next_state = WALK_LEFT;
        end else begin
          next_state = WALK_RIGHT;
        end
      end
    end
    
    DIGGING: begin
      if (!ground) begin
        next_state = FALLING;
      end
    end
    
    SPLATTERED: begin
      next_state = SPLATTERED;
    end
  endcase
end

assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALLING);
assign digging = (state == DIGGING);

endmodule
