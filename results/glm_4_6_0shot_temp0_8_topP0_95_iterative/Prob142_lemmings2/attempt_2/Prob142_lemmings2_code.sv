
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

  // State encoding for the Moore state machine
  // We need 4 states to track both direction and whether falling
  parameter WALK_LEFT = 2'b00;
  parameter WALK_RIGHT = 2'b01;
  parameter FALL_LEFT = 2'b10;
  parameter FALL_RIGHT = 2'b11;
  
  reg [1:0] state, next_state;
  
  // State transition logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
    end else begin
      state <= next_state;
    end
  end
  
  // Next state combinational logic
  always @(*) begin
    case (state)
      WALK_LEFT: begin
        if (!ground) begin
          next_state = FALL_LEFT;
        end else if (bump_left || bump_right) begin
          next_state = WALK_RIGHT;
        end else begin
          next_state = WALK_LEFT;
        end
      end
      
      WALK_RIGHT: begin
        if (!ground) begin
          next_state = FALL_RIGHT;
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
      
      default: next_state = WALK_LEFT;
    endcase
  end
  
  // Output logic (Moore machine - outputs depend only on current state)
  assign walk_left = (state == WALK_LEFT);
  assign walk_right = (state == WALK_RIGHT);
  assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
  
endmodule
