
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

reg state; // Current state of the FSM (0: walking left, 1: walking right)
reg falling; // Is the Lemming currently falling?
reg digging_state; // State of the digging sub-FSM (0: not digging, 1: digging)
reg splattered; // Has the Lemming splattered?
reg count; // Counts the number of clock cycles since the last ground change or reset

always @(posedge clk) begin
  if (areset) begin
    state <= 0;
    falling <= 0;
    digging_state <= 0;
    splattered <= 0;
    count <= 0;
  end else if (ground == 1 && !falling) begin
    // If the Lemming is on ground and not falling, it can start digging if dig=1
    if (dig) begin
      digging_state <= 1;
    end
  end else if (ground == 0 && !falling) begin
    // If the Lemming falls off the ground, it says "aaah!" and starts falling
    aaah <= 1;
    falling <= 1;
    count <= 0;
  end else if (falling) begin
    // While falling, the Lemming doesn't change direction or start digging
    if (count >= 20) begin
      splattered <= 1;
      // If the Lemming has fallen for too long, it splatters and stops moving
      walk_left <= 0;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
    end else begin
      count <= count + 1;
    end
  end else if (bump_left) begin
    // If the Lemming is bumped on the left, it switches direction
    state <= ~state;
  end else if (bump_right) begin
    // If the Lemming is bumped on the right, it switches direction
    state <= ~state;
  end

  // Update outputs based on current state and sub-FSM states
  walk_left <= state;
  walk_right <= ~state;
  aaah <= !falling && (!splattered || falling);
  digging <= digging_state;
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
