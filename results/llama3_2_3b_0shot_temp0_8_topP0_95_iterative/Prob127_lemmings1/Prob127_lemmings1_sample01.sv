
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
module internal_states (
  input clk,
  input areset,
  output reg [1:0] walking_left, 
  output reg [1:0] walking_right
);

reg [1:0] lemming_state_value;

always @(posedge clk or negedge areset) begin
  if (areset) {
    // Asynchronous reset to "walking_left"
    lemming_state_value <= walking_left;
    walking_left <= walking_left; 
    walking_right <= 1'b0;
  } else if (!walking_left && bump_left) begin
    lemming_state_value <= walking_right;
    walking_left <= 1'b0;
    walking_right <= walking_left;
  end else if (walking_left && !bump_left && !bump_right) begin
    // No change when no obstacles are present, stay in "walking_left" state.
    lemming_state_value <= walking_left;
    walking_left <= 1'b1;
    walking_right <= walking_left;
  end else if (!walking_left && bump_right) begin
    lemming_state_value <= walking_right;
    walking_left <= 1'b0;
    walking_right <= walking_left;
  end else if (walking_left && !bump_right && bump_left) begin
    // When both bump inputs are true, switch direction to "walking_right".
    lemming_state_value <= walking_right;
    walking_left <= walking_left;
    walking_right <= 1'b1;
  end
end

assign walk_left = walking_left; 
assign walk_right = walking_right;

endmodule internal_states;

// Connect the outputs of internal states to external inputs/outputs
internal_states u_top_module (
  .clk(clk),
  .areset(areset),
  .walking_left(walk_left),
  .walking_right(walk_right)
);

endmodule // TopModule
