
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
// State register: 0 = walk_left, 1 = walk_right
reg state;

// Asynchronous reset (positive edge) and synchronous state update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0;          // Reset to walk_left
    end else begin
        // Toggle state if either bump_left or bump_right is asserted
        state <= state ^ (bump_left | bump_right);
    end
end

// Output logic (Moore outputs)
assign walk_left  = ~state;
assign walk_right =  state;

// VERILOG-EVAL: endmodule not found
