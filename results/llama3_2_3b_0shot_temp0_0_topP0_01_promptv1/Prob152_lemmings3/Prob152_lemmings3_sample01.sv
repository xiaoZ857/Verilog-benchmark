
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
assign walk_left = !walk_right;
assign walk_right = !walk_left;

always @(posedge clk) begin
    if (areset)
        walk_left <= 1'b0;
    else
        walk_left <= bump_left & !ground;
end

assign aaah = ground == 0;

always @(posedge clk) begin
    if (areset)
        digging <= 1'b0;
    else if (!ground && dig)
        digging <= 1'b1;
    else if (digging && !ground)
        digging <= 1'b0;
end

assign walk_left = walk_left;
assign walk_right = walk_right;

always @(posedge clk) begin
    if (areset)
        digging <= 1'b0;
    else if (!ground && dig)
        digging <= 1'b1;
    else if (digging && !ground)
        digging <= 1'b0;
end

assign digging = digging;

assign walk_left = walk_left;
assign walk_right = walk_right;

// VERILOG-EVAL: endmodule not found
