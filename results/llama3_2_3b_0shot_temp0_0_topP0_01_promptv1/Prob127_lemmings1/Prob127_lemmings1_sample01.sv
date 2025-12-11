
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
assign walk_left = !walk_right;
assign walk_right = (bump_left | bump_right) & ~walk_left;

always @(posedge clk or negedge areset)
begin
    if (areset)
        walk_left <= 1'b0;
    else
        walk_left <= a[0];
end

always @(posedge clk or negedge areset)
begin
    if (areset)
        walk_right <= 1'b0;
    else
        walk_right <= a[1];
end

// VERILOG-EVAL: endmodule not found
