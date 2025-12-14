
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
  if (areset) begin
    state <= 0; // reset to walking left
    fall_counter <= 0; // clear the fall counter
  end
  else if (!fall_counter && ground && !dig) begin // ground appears and no falling or digging
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
  else if (!ground && !fall_counter) begin // ground disappears and no falling
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

always @(posedge clk) begin
  if (state == 1 && ground && !fall_counter && !dig) begin // digging while on ground
    digging <= 1; // start digging
  end
  else if (ground && !fall_counter) begin // walking while on ground
    if (!dig) begin // not digging
      if (bump_left && (!bump_right || fall_counter)) begin // bumped on the left
        walk_left <= 0;
        walk_right <= 1;
      end
      else if (bump_right && (!bump_left || fall_counter)) begin // bumped on the right
        walk_left <= 1;
        walk_right <= 0;
      end
    end
  end
end

// Assigning the outputs based on the current state
assign walk_left = (state == 0 || state == 2);
assign walk_right = (state == 2 || state == 3);

endmodule
