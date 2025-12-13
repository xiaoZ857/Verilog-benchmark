
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

reg [1:0] state; // State of the Lemming (00 = walking left, 01 = walking right)
reg [1:0] prev_state; // Previous state of the Lemming
reg [1:0] fall_count; // Number of clock cycles since the Lemming fell

// Initialize the state and fall count to default values
initial begin
  state = 2; // Walking left (default state)
  prev_state = 2;
  fall_count = 0;
end

always @(posedge clk) begin
  if (areset) begin // Asynchronous reset
    state <= 2; // Reset the Lemming to walk left
    fall_count <= 0;
  end else begin
    // Update the state based on the current inputs
    if ((bump_left && !state[1]) || (bump_right && !state[0])) begin // Bumped from one side, switch direction
      if (state == 2) state <= 1; // Switch to walking right
      else state <= 0;
    end

    if (ground == 0) begin // Lemming is falling
      fall_count <= fall_count + 1;
      if (fall_count > 20) begin // Lemming has fallen for too long, splatter
        state <= 2; // Reset the Lemming to walk left
        fall_count <= 0;
      end else if ((dig && prev_state == 2) || (bump_left && !state[1]) || (bump_right && !state[0])) begin // Digging or bumped while falling, ignore dig and bump signals
        state <= 2; // Reset the Lemming to walk left
        fall_count <= 0;
      end else if ((dig && prev_state == 1) || (bump_left && state[1]) || (bump_right && state[0])) begin // Digging, bumped from one side while walking, switch direction
        if (state == 2) state <= 1; // Switch to walking right
        else state <= 0;
      end
    end else if (ground == 1) begin // Lemming is on the ground
      if ((dig && prev_state == 2) || (bump_left && !state[1]) || (bump_right && !state[0])) begin // Digging or bumped, ignore dig and bump signals
        state <= 2; // Reset the Lemming to walk left
        fall_count <= 0;
      end else if ((dig && prev_state == 1) || (bump_left && state[1]) || (bump_right && state[0])) begin // Digging, bumped from one side while walking, switch direction
        if (state == 2) state <= 1; // Switch to walking right
        else state <= 0;
      end
    end

    prev_state <= state; // Update the previous state for next clock cycle
  end
end

assign walk_left = (state == 0); // Walking left output
assign walk_right = (state == 1); // Walking right output
assign aaah = (ground == 0 && fall_count > 20); // Fall output
assign digging = ((dig && prev_state == 2) || (bump_left && !state[1]) || (bump_right && !state[0])); // Digging output

endmodule

// VERILOG-EVAL: errant inclusion of module definition
