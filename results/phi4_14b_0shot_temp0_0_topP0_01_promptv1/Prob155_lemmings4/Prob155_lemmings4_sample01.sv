
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
reg [4:0] state, next_state;
wire fall_count_reset;

assign fall_count_reset = (ground == 1'b1) ? 1'b1 : 1'b0;

always @(posedge areset or posedge clk) begin
    if (areset)
        state <= 5'd0; // Initial state: walk_left
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        5'd0: begin // Walk Left
            if (!ground)
                next_state = 5'd1; // Fall
            else if (bump_right)
                next_state = 5'd2; // Walk Right
            else if (dig && ground)
                next_state = 5'd3; // Digging
            else
                next_state = 5'd0;
        end

        5'd1: begin // Fall
            if (!ground)
                next_state = 5'd1;
            else if (fall_count >= 20)
                next_state = 5'd4; // Splatter
            else
                next_state = state[3:0]; // Resume previous direction
        end

        5'd2: begin // Walk Right
            if (!ground)
                next_state = 5'd1;
            else if (bump_left)
                next_state = 5'd0; // Walk Left
            else if (dig && ground)
                next_state = 5'd3; // Digging
            else
                next_state = 5'd2;
        end

        5'd3: begin // Digging
            if (!ground)
                next_state = 5'd1;
            else
                next_state = state[3:0]; // Continue digging or resume direction
        end

        5'd4: begin // Splatter
            next_state = 5'd4; // Remain in splatter state
        end

        default: next_state = 5'd0;
    endcase
end

reg [4:0] fall_count;

always @(posedge clk) begin
    if (areset)
        fall_count <= 5'd0;
    else if (state == 5'd1 && !fall_count_reset)
        fall_count <= fall_count + 1'b1;
    else if (fall_count_reset)
        fall_count <= 5'd0;
end

assign walk_left = (state == 5'd0);
assign walk_right = (state == 5'd2);
assign aaah = (state == 5'd1 || state == 5'd3 && !ground);
assign digging = (state == 5'd3);

endmodule
