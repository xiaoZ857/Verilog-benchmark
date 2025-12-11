
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
assign walk_left = !walk_right;
assign walk_right = !walk_left;

always @(*) begin
    if (reset)
        walk_left <= 1'b0;
    else if (ground == 0 && walk_left != walk_right) // falling down, change direction only when leaving ground
        walk_left <= ~walk_left;
    else if (ground == 0) 
        walk_left <= walk_left;

    if (reset)
        walk_right <= 1'b0;
    else if (ground == 0 && walk_right != walk_left) // falling down, change direction only when leaving ground
        walk_right <= ~walk_right;
    else if (ground == 0) 
        walk_right <= walk_right;

    assign aaah = !ground;
endmodule
