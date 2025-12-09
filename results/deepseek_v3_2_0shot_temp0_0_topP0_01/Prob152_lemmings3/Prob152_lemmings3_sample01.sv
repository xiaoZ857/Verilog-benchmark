
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
    parameter WL = 3'd0, WR = 3'd1, FALL_L = 3'd2, FALL_R = 3'd3, DIG_L = 3'd4, DIG_R = 3'd5;
    reg [2:0] state, next_state;

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
                if (ground) next_state = WL;
                else next_state = FALL_L;
            end
            FALL_R: begin
                if (ground) next_state = WR;
                else next_state = FALL_R;
            end
            DIG_L: begin
                if (~ground) next_state = FALL_L;
                else next_state = DIG_L;
            end
            DIG_R: begin
                if (~ground) next_state = FALL_R;
                else next_state = DIG_R;
            end
            default: next_state = WL;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= WL;
        else state <= next_state;
    end

    assign walk_left = (state == WL) | (state == FALL_L) | (state == DIG_L);
    assign walk_right = (state == WR) | (state == FALL_R) | (state == DIG_R);
    assign aaah = (state == FALL_L) | (state == FALL_R);
    assign digging = (state == DIG_L) | (state == DIG_R);
endmodule
