
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
        // Default assignments (to avoid latches)
        walk_left <= walk_left;
        walk_right <= walk_right;
        aaah <= aaah;
        digging <= digging;
    end
end

endmodule
