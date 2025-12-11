
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

always @(*) begin
    if (reset)
        walk_left <= 1'b0;
    
    if ((ground == 1 && dig) || walk_left && ~dig)
        dig <= 1'b1;
    else 
        dig <= 1'b0;
        
    if (~ground && !walk_right)
        walk_right <= 1'b1;
    else
        walk_right <= walk_right;

    if (ground == 0 && ~bump_left)
        walk_left <= 1'b1;
    else
        walk_left <= walk_left;

    if (ground == 0 && ~bump_right)
        walk_right <= 1'b1;
    else
        walk_right <= walk_right;

    if ((bump_left || bump_right) && ground != 0 && digging)
        digging <= 1'b0;
    else 
        digging <= !digging;

    assign aaah = ~ground && walk_left;
endmodule
