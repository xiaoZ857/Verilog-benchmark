
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

  // Next state logic
  always @(*) begin
    case (state)
      STATE_LEFT: begin
        if (bump_left) begin
          next_state = STATE_RIGHT;
        end else begin
          next_state = STATE_LEFT;
        end
      end
      STATE_RIGHT: begin
        if (bump_right) begin
          next_state = STATE_LEFT;
        end else begin
          next_state = STATE_RIGHT;
        end
      end
      default: begin
        next_state = STATE_LEFT;
      end
    endcase
  end
  
  // Output logic (Moore machine - outputs depend only on current state)
  assign walk_left = (state == STATE_LEFT);
  assign walk_right = (state == STATE_RIGHT);

endmodule
