
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);
always_ff @(posedge clk or negedge resetn) begin
    if (!resetn)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

always_comb begin
    // Default outputs and transitions
    f = 0;
    g = (current_state == STATE_HOLD_G1 || current_state == STATE_YWAIT_2);
    
    case (current_state)
        STATE_A: begin
            if (!resetn) 
                next_state = STATE_F1;  // Start setting `f` to 1 after reset deassertion
            else
                next_state = STATE_A;
        end

        STATE_F1: begin
            f = 1;  // Set `f` for one clock cycle
            next_state = STATE_X0;
        end

        STATE_X0: begin
            if (x == 1)
                next_state = STATE_X1;  // First part of sequence detected
            else
                next_state = STATE_A;
        end

        STATE_X1: begin
            if (x == 0)
                next_state = STATE_X2;  // Transition to second state after detecting `1`, then `0`
            else
                next_state = STATE_A;
        end

        STATE_X2: begin
            if (x == 1)
                next_state = STATE_G1;  // Full sequence detected, set `g` in the next cycle
            else
                next_state = STATE_A;
        end

        STATE_G1: begin
            g = 1;  // Set `g` to 1
            next_state = STATE_YWAIT_1;
        end

        STATE_YWAIT_1: begin
            if (y == 1)
                next_state = STATE_HOLD_G1;  // If y becomes 1 in first wait cycle, hold `g`
            else
                next_state = STATE_YWAIT_2;  // Otherwise, proceed to second wait cycle
        end

        STATE_YWAIT_2: begin
            if (y == 1)
                next_state = STATE_HOLD_G1;  // If y becomes 1 in second wait cycle, hold `g`
            else
                next_state = STATE_CLEAR_G;  // Otherwise, clear `g` permanently
        end

        STATE_HOLD_G1: begin
            next_state = STATE_HOLD_G1;  // Remain in this state to keep `g` high
        end

        STATE_CLEAR_G: begin
            g = 0;  // Set `g` to 0 permanently
            next_state = STATE_A;
        end

        default: begin
            next_state = STATE_A;
        end
    endcase
end

endmodule
