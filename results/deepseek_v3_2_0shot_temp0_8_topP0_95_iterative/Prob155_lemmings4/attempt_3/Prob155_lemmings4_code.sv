
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
    parameter WL = 0, WR = 1, FALL_L = 2, FALL_R = 3, DIG_L = 4, DIG_R = 5, SPLAT = 6;
    reg [2:0] state, next_state;
    reg [4:0] fall_count;
    reg walking_left_before_fall;  // Remember direction before falling
    
    // State register
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= WL;
            fall_count <= 0;
            walking_left_before_fall <= 1;
        end else begin
            state <= next_state;
            
            // Update fall counter
            if (state == FALL_L || state == FALL_R) begin
                if (ground) begin
                    fall_count <= 0;  // Reset when hitting ground
                end else begin
                    fall_count <= fall_count + 1;  // Increment while falling
                end
            end else begin
                fall_count <= 0;  // Reset when not falling
            end
            
            // Remember walking direction before falling
            if ((state == WL || state == WR) && ground) begin
                walking_left_before_fall <= (state == WL);
            end
        end
    end
    
    // Next state logic with proper priority
    always @(*) begin
        case (state)
            WL: begin
                if (~ground) next_state = FALL_L;
                else if (dig) next_state = DIG_L;
                else if (bump_left) next_state = WR;
                else next_state = WL;
            end
            WR: begin
                if (~ground) next_state = FALL_R;
                else if (dig) next_state = DIG_R;
                else if (bump_right) next_state = WL;
                else next_state = WR;
            end
            FALL_L: begin
                if (ground) begin
                    if (fall_count > 20) next_state = SPLAT;
                    else next_state = (walking_left_before_fall ? WL : WR);
                end else begin
                    next_state = FALL_L;
                end
            end
            FALL_R: begin
                if (ground) begin
                    if (fall_count > 20) next_state = SPLAT;
                    else next_state = (walking_left_before_fall ? WL : WR);
                end else begin
                    next_state = FALL_R;
                end
            end
            DIG_L: begin
                if (~ground) next_state = FALL_L;
                else next_state = DIG_L;
            end
            DIG_R: begin
                if (~ground) next_state = FALL_R;
                else next_state = DIG_R;
            end
            SPLAT: next_state = SPLAT;
            default: next_state = WL;
        endcase
    end
    
    // Output logic (Moore: outputs depend only on state)
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);
    assign aaah = (state == FALL_L || state == FALL_R);
    assign digging = (state == DIG_L || state == DIG_R);
endmodule
