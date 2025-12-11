
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

assign aaah = ~ground;

always @(posedge clk) begin
    digging <= dig & walk_left;
end

always @(posedge clk) begin
    if (!digging && walk_left)
        walk_right <= 1'b0;
    end else if (walk_left)
        walk_right <= bump_right;
    end else if (walk_right)
        walk_right <= !bump_right;
    end else if (ground == 0 && walk_right) begin
        walk_right <= 1'b0;
        aaah <= 1'b1;
    end else if (ground == 1 && walk_left) begin
        walk_left <= 1'b0;
        aaah <= 1'b0;
    end else if (walk_left && !digging)
        walk_left <= bump_right;
    end else if (walk_right && !digging)
        walk_right <= bump_left;
    end else if (!ground) begin
        walk_left <= 1'b0;
        walk_right <= 1'b0;
        aaah <= 1'b1;
    end else if (walk_left && dig) begin
        walk_left <= 1'b0;
        digging <= 1'b0;
    end else if (walk_right && dig) begin
        walk_right <= 1'b0;
        digging <= 1'b0;
    end else if (!digging)
        digging <= 1'b0;
    end else if (bump_left && bump_right) begin
        walk_left <= !walk_right;
        walk_right <= !walk_left;
    end else if (ground == 0 && dig) begin
        walk_left <= 1'b0;
        walk_right <= 1'b0;
        digging <= 1'b0;
    end else if (ground == 1 && dig) begin
        walk_left <= 1'b0;
        walk_right <= 1'b0;
        digging <= 1'b0;
    end else if (!digging)
        digging <= 1'b0;
end

assign walk_left = walk_left;
assign walk_right = walk_right;

endmodule
