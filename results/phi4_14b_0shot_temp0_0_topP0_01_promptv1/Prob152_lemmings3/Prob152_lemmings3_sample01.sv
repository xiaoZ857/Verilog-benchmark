
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

localparam IDLE_LEFT = 3'b000,
           WALK_RIGHT = 3'b001,
           FALLING = 3'b010,
           DIGGING = 3'b011,
           IDLE_RIGHT = 3'b100;

always @(posedge areset or posedge clk) begin
    if (areset)
        state <= IDLE_LEFT;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE_LEFT: begin
            if (!ground)
                next_state = FALLING;
            else if (bump_left || dig)
                next_state = WALK_RIGHT;
            else
                next_state = IDLE_LEFT;
        end
        
        WALK_RIGHT: begin
            if (!ground)
                next_state = FALLING;
            else if (bump_right)
                next_state = IDLE_LEFT;
            else if (dig)
                next_state = DIGGING;
            else
                next_state = WALK_RIGHT;
        end

        FALLING: begin
            if (ground)
                next_state = state; // Resume previous direction
            else
                next_state = FALLING;
        end
        
        DIGGING: begin
            if (!ground)
                next_state = FALLING;
            else if (state == WALK_RIGHT)
                next_state = IDLE_RIGHT;
            else
                next_state = IDLE_LEFT;
        end

        IDLE_RIGHT: begin
            if (!ground)
                next_state = FALLING;
            else if (bump_right || dig)
                next_state = IDLE_LEFT;
            else
                next_state = IDLE_RIGHT;
        end
        
        default: next_state = IDLE_LEFT;
    endcase
end

assign walk_left = (state == IDLE_LEFT) | (state == FALLING && previous_state != WALK_RIGHT);
assign walk_right = (state == WALK_RIGHT) | (state == DIGGING) | (state == IDLE_RIGHT) | (state == FALLING && previous_state == WALK_RIGHT);

always @(posedge clk or posedge areset) begin
    if (areset)
        previous_state <= IDLE_LEFT;
    else
        previous_state <= state;
end

assign aaah = (state == FALLING);
assign digging = (state == DIGGING);

endmodule
