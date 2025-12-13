
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
    parameter WL = 3'd0, WR = 3'd1, FL = 3'd2, FR = 3'd3, DL = 3'd4, DR = 3'd5, SPLAT = 3'd6;
    reg [2:0] state, next_state;
    reg [4:0] fall_timer; // enough for >20
    
    // State register
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= WL;
            fall_timer <= 0;
        end else begin
            state <= next_state;
            // Fall timer logic
            if (state == FL || state == FR) begin
                if (ground) begin
                    // landing now, timer resets next cycle if not falling
                    fall_timer <= 0;
                end else begin
                    fall_timer <= fall_timer + 1;
                end
            end else begin
                fall_timer <= 0;
            end
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            WL: begin
                if (~ground) next_state = FL;
                else if (dig) next_state = DL;
                else if (bump_left) next_state = WR;
                else next_state = WL;
            end
            WR: begin
                if (~ground) next_state = FR;
                else if (dig) next_state = DR;
                else if (bump_right) next_state = WL;
                else next_state = WR;
            end
            FL: begin
                if (ground) begin
                    if (fall_timer >= 20) next_state = SPLAT;
                    else next_state = WL;
                end else next_state = FL;
            end
            FR: begin
                if (ground) begin
                    if (fall_timer >= 20) next_state = SPLAT;
                    else next_state = WR;
                end else next_state = FR;
            end
            DL: begin
                if (~ground) next_state = FL;
                else next_state = DL;
            end
            DR: begin
                if (~ground) next_state = FR;
                else next_state = DR;
            end
            SPLAT: next_state = SPLAT;
            default: next_state = WL;
        endcase
    end
    
    // Output logic (Moore)
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);
    assign aaah = (state == FL || state == FR);
    assign digging = (state == DL || state == DR);

// VERILOG-EVAL: endmodule not found
