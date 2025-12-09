
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
    localparam LEFT       = 3'd0;
    localparam RIGHT      = 3'd1;
    localparam FALL_LEFT  = 3'd2;
    localparam FALL_RIGHT = 3'd3;
    localparam DIG_LEFT   = 3'd4;
    localparam DIG_RIGHT  = 3'd5;
    localparam SPLAT      = 3'd6;

    reg [2:0] state, next_state;
    reg [4:0] fall_cycles; // enough to count >20

    // State register
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_cycles <= 0;
        end else begin
            state <= next_state;
            // Fall cycle counter
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                if (ground) begin
                    fall_cycles <= 0; // landing, reset counter
                end else begin
                    fall_cycles <= fall_cycles + 1;
                end
            end else begin
                fall_cycles <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (~ground)          next_state = FALL_LEFT;
                else if (dig)         next_state = DIG_LEFT;
                else if (bump_left)   next_state = RIGHT;
                else if (bump_right)  next_state = LEFT; // redundant but clear
                else                  next_state = LEFT;
            end
            RIGHT: begin
                if (~ground)          next_state = FALL_RIGHT;
                else if (dig)         next_state = DIG_RIGHT;
                else if (bump_right)  next_state = LEFT;
                else if (bump_left)   next_state = RIGHT; // redundant
                else                  next_state = RIGHT;
            end
            DIG_LEFT: begin
                if (~ground)          next_state = FALL_LEFT;
                else                  next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (~ground)          next_state = FALL_RIGHT;
                else                  next_state = DIG_RIGHT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_cycles > 20) next_state = SPLAT;
                    else                  next_state = LEFT;
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_cycles > 20) next_state = SPLAT;
                    else                  next_state = RIGHT;
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            SPLAT: begin
                next_state = SPLAT;
            end
            default: next_state = LEFT;
        endcase
    end

    // Output logic (Moore)
    assign walk_left  = (state == LEFT) || (state == DIG_LEFT);
    assign walk_right = (state == RIGHT) || (state == DIG_RIGHT);
    assign aaah       = (state == FALL_LEFT) || (state == FALL_RIGHT);
    assign digging    = (state == DIG_LEFT) || (state == DIG_RIGHT);
