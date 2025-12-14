
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output reg walk_left,
  output reg walk_right,
  output reg aaah,
  output reg digging
);

reg state; // finite state machine's current state
reg fall_counter; // counter for the falling state

always @(posedge clk) begin
  if (areset) begin
    state <= 0; // reset to walking left
    fall_counter <= 0; // clear the fall counter
  end
  else if (ground && !fall_counter) begin // ground appears and no falling
    if (dig) begin // start digging
      state <= 1; // set the dig state
    end
    else begin // switch direction or keep walking
      if (bump_left && (!bump_right || fall_counter)) begin // bumped on the left
        walk_left <= 0;
        walk_right <= 1;
        state <= 2; // set the right walking state
      end
      else if (bump_right && (!bump_left || fall_counter)) begin // bumped on the right
        walk_left <= 1;
        walk_right <= 0;
        state <= 3; // set the left walking state
      end
      else begin // keep walking or switch direction if necessary
        walk_left <= state == 0;
        walk_right <= state == 2;
      end
    end
  end
  else if (!ground) begin // ground disappears and no falling
    fall_counter <= fall_counter + 1; // increment the fall counter
    aaah <= 0; // reset the aah signal
  end
  else if (fall_counter > 20) begin // hit the ground after too many falls
    state <= 4; // set the splattered state
    aaah <= 1; // set the aah signal
    walk_left <= 0;
    walk_right <= 0;
    digging <= 0;
  end
end

always @(posedge clk) begin
  if (state == 4) begin // splattered state
    fall_counter <= 0; // clear the fall counter
  end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
