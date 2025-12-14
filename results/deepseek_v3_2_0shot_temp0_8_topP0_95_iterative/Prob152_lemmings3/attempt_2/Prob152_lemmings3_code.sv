
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
    localparam WL = 3'd0,
               WR = 3'd1,
               FALL_L = 3'd2,
               FALL_R = 3'd3,
               DIG_L = 3'd4,
               DIG_R = 3'd5,
               FALLING_L = 3'd6,  // Falling while originally walking left
               FALLING_R = 3'd7;  // Falling while originally walking right
    
    // State register
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            WL: begin
                if (~ground)
                    next_state = FALLING_L;  // Fall, remember we were walking left
                else if (dig)
                    next_state = DIG_L;
                else if (bump_left)
                    next_state = WR;
                else
                    next_state = WL;
            end
            WR: begin
                if (~ground)
                    next_state = FALLING_R;  // Fall, remember we were walking right
                else if (dig)
                    next_state = DIG_R;
                else if (bump_right)
                    next_state = WL;
                else
                    next_state = WR;
            end
            FALLING_L: begin
                if (ground)
                    next_state = WL;  // Resume walking left
                else
                    next_state = FALLING_L;
            end
            FALLING_R: begin
                if (ground)
                    next_state = WR;  // Resume walking right
                else
                    next_state = FALLING_R;
            end
            DIG_L: begin
                if (~ground)
                    next_state = FALLING_L;  // Fall while remembering original left direction
                else
                    next_state = DIG_L;
            end
            DIG_R: begin
                if (~ground)
                    next_state = FALLING_R;  // Fall while remembering original right direction
                else
                    next_state = DIG_R;
            end
            default: next_state = WL;
        endcase
    end
    
    // Output logic (Moore)
    assign walk_left = (state == WL) | (state == DIG_L);
    assign walk_right = (state == WR) | (state == DIG_R);
    assign aaah = (state == FALLING_L) | (state == FALLING_R);
    assign digging = (state == DIG_L) | (state == DIG_R);
endmodule

// VERILOG-EVAL: abnormal backticks count
