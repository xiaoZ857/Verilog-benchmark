
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
        // Default outputs (will be overridden by state transitions)
        walk_left <= walk_left;
        walk_right <= walk_right;
        aaah <= aaah;
        digging <= digging;
        
        // State transitions based on priority: fall > dig > switch direction
        if (~ground) begin
            // Falling state
            aaah <= 1'b1;
            digging <= 1'b0;
            // Keep walking direction unchanged while falling
        end else if (dig && ground && ~aaah) begin
            // Start digging if on ground and not falling
            digging <= 1'b1;
            aaah <= 1'b0;
            // Keep walking direction unchanged while digging
        end else begin
            // Not falling and not digging - handle walking and direction changes
            aaah <= 1'b0;
            digging <= 1'b0;
            
            // Direction change logic (only when on ground and not falling/digging)
            if (bump_left && ~bump_right) begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end else if (bump_right && ~bump_left) begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end else if (bump_left && bump_right) begin
                // Switch directions when bumped on both sides
                walk_left <= ~walk_left;
                walk_right <= ~walk_right;
            end
        end
    end
end

endmodule
