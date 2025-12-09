

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

reg [1:0] state, next_state;

localparam IDLE_LEFT = 2'b00;
localparam WALK_RIGHT = 2'b01;
localparam FALLING = 2'b10;
localparam WALK_LEFT = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= IDLE_LEFT;
    else
        state <= next_state;
end

assign walk_left = (state == IDLE_LEFT || state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALLING);

always @(*) begin
    case (state)
        IDLE_LEFT: begin
            if (!ground)
                next_state = FALLING;
            else if (bump_left)
                next_state = WALK_RIGHT;
            else
                next_state = IDLE_LEFT;
        end

        WALK_RIGHT: begin
            if (!ground)
                next_state = FALLING;
            else if (bump_right)
                next_state = WALK_LEFT;
            else
                next_state = WALK_RIGHT;
        end

        FALLING: begin
            if (ground) begin
                if (state == IDLE_LEFT)
                    next_state = IDLE_LEFT;
                else if (state == WALK_RIGHT)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT; // Default to walk left after fall
            end else
                next_state = FALLING;
        end

        WALK_LEFT: begin
            if (!ground)
                next_state = FALLING;
            else if (bump_right)
                next_state = WALK_RIGHT;
            else
                next_state = WALK_LEFT;
        end

        default: next_state = IDLE_LEFT;
    endcase
end

endmodule
