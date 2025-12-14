
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
  // Internal state: 1 = walk_left, 0 = walk_right
  logic state;

  // Output assignments (Moore outputs)
  assign walk_left  = state;
  assign walk_right = ~state;

  // State transition with asynchronous positive‑edge reset
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 1'b1;            // Reset to walk_left
    end else begin
      // Toggle direction if any bump occurs
      state <= state ^ (bump_left | bump_right);
    end
  end
endmodule
