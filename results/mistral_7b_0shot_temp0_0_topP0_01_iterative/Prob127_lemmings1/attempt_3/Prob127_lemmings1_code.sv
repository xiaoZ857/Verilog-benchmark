
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
always @(posedge clk or negedge areset) begin
    if (areset) begin
        walk_left <= 1'b1; // Reset to walking left
        walk_right <= 1'b0;
    end else begin
        temp <= (!walk_left && !bump_right) || (!walk_right && bump_left); // Check for direction switch condition
        if (temp) begin
            walk_left <= !(walk_left); // Switch direction when bumped on the opposite side
            walk_right <= !(walk_left);
        end
    end
end

assign state = walk_left ? 0 : 1; // Assign state based on walk_left value

// Continuous assignment for outputs
assign walk_left = state == 0;
assign walk_right = state == 1;

endmodule
