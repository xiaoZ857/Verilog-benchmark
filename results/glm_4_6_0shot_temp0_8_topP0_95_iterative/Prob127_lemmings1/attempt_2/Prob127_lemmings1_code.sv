
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);

// State encoding for the Lemmings FSM
parameter WALK_LEFT = 2'b01;
parameter WALK_RIGHT = 2'b10;

reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge areset or posedge clk) begin
  if (areset) begin
    current_state <= WALK_LEFT;
  end else begin
    current_state <= next_state;
  end
end

always @(*) begin
  next_state = current_state;
  
  case (current_state)
    WALK_LEFT: begin
      if (bump_left) begin
        next_state = WALK_RIGHT;
      end
    end
    
    WALK_RIGHT: begin
      if (bump_right) begin
        next_state = WALK_LEFT;
      end
    end
    
    default: begin
      next_state = WALK_LEFT;
    end
  endcase
end

// Output logic (Moore machine - outputs depend only on current state)
assign walk_left = (current_state == WALK_LEFT);
assign walk_right = (current_state == WALK_RIGHT);

endmodule
