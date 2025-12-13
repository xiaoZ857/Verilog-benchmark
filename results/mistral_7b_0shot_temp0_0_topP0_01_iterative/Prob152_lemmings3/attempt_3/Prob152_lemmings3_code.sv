
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
always @(posedge clk or negedge areset) begin
  if (!areset) begin
    state <= 0; // Reset to Walk Left on positive edge of areset
  end else begin
    case (state)
      0: begin
        if (bump_left) begin
          state <= 1; // Switch to Walk Right when bumped left
        end
        if (ground && !dig && state != 2) begin
          state <= 2; // Fall when on ground and not digging
        end
      end,
      1: begin
        if (bump_right) begin
          state <= 0; // Switch to Walk Left when bumped right
        end
        if (!ground && state != 2 && state != 3) begin // Can't fall or dig when ground is 0
          state <= 3; // Start digging when on ground and not falling
        end
      end,
      2: begin // Falling state
        aaah <= 1; // Lemming says "aaah!"
        if (ground) begin
          state <= 0; // Resume walking left once ground appears again
        end
      end,
      3: begin // Digging state
        digging <= 1;
        if (!ground && state != 2) begin
          aaah <= 1; // Lemming says "aaah!" when ground disappears while digging
          state <= 4; // Fall once ground disappears
        end
      end,
      4: begin // Falling state after digging
        if (ground) begin
          state <= 0; // Resume walking left once ground appears again
        end
      end
    endcase
  end
end

assign walk_left = (state == 0 || state == 4);
assign walk_right = (state == 1);

// VERILOG-EVAL: endmodule not found
