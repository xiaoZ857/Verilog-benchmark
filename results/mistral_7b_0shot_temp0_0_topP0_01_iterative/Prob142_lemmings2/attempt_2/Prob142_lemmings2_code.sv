
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
        state <= 2'b1; // reset to idle state
    end else if (!ground && (state != 2'b1)) begin
        state <= 2'b0; // start walking left when ground disappears
    end else if ((ground == 1 || (state != 2'b1)) && (!(bump_left ^ walk_left) && !(bump_right ^ walk_right))) begin
        state <= {walk_left, walk_right}; // switch direction when bumped or ground reappears
    end else if ((ground == 0 && (state != 2'b1)) && (!bump_left && !bump_right)) begin
        aaah <= 1; // Lemming says "aaah!" when falling and not bumped
    end
end

assign walk_left = state[0];
assign walk_right = state[1];
assign aaah = (state == 2'b1); // Lemming says "aaah!" only when in the falling state

// VERILOG-EVAL: endmodule not found
