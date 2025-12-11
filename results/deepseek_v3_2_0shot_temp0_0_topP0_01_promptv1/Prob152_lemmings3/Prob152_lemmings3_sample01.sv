
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
always @(posedge clk or posedge areset) begin
    if (areset) begin
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end else begin
        // Default assignments (hold state)
        walk_left <= walk_left;
        walk_right <= walk_right;
        aaah <= aaah;
        digging <= digging;
        
        // State transitions
        if (ground == 1'b0) begin
            // Falling state
            aaah <= 1'b1;
            digging <= 1'b0;
            // Keep walk_left/walk_right as they were before falling
        end else if (ground == 1'b1 && aaah == 1'b1) begin
            // Ground reappeared while falling
            aaah <= 1'b0;
            digging <= 1'b0;
            // Resume walking in previous direction (walk_left/walk_right unchanged)
        end else if (ground == 1'b1 && aaah == 1'b0) begin
            // On ground and not falling
            if (dig == 1'b1 && digging == 1'b0) begin
                // Start digging
                digging <= 1'b1;
                aaah <= 1'b0;
                // Keep walk_left/walk_right as they were
            end else if (digging == 1'b1) begin
                // Continue digging (until ground disappears)
                aaah <= 1'b0;
                // Keep walk_left/walk_right as they were
            end else begin
                // Walking state - handle direction changes
                digging <= 1'b0;
                aaah <= 1'b0;
                if (bump_left == 1'b1 && bump_right == 1'b0) begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end else if (bump_right == 1'b1 && bump_left == 1'b0) begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end else if (bump_left == 1'b1 && bump_right == 1'b1) begin
                    // Both sides bumped - switch direction
                    walk_left <= ~walk_left;
                    walk_right <= ~walk_right;
                end
            end
        end
    end
end

endmodule
