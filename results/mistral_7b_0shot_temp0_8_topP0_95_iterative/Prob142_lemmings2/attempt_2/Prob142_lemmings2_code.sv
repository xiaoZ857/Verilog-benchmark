
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
);
always @(posedge clk or negedge areset) begin
  if (areset) begin
    state <= 0; // Reset to walking left when areset is high
    walk_left <= 1;
    walk_right <= 0;
    aaah <= 0;
  end else if (ground == 0 && state != 1) begin // Falling only when ground disappears and not already falling
    state <= 2;
  end

  assign walk_left = state[0]; // Assign walk_left directly in the continuous assignment
  assign walk_right = state[1]; // Assign walk_right directly in the continuous assignment

  always @(posedge clk) begin
    if (ground == 1 && state == 2) begin // Resume walking when ground reappears and currently falling
      state <= state[0]; // Go back to original walking direction
      aaah <= 0;
    end else if (bump_left && !walk_left || bump_right && walk_right) begin // Change direction when bumped
      state <= ~state;
    end
    if (aaah == 1) begin // Set aaah output only if falling
      aaah <= 1;
    end else if (aaah == 0 && ground == 1) begin // Clear aaah output when ground reappears and not falling
      aaah <= 0;
    end
  end
end

endmodule
