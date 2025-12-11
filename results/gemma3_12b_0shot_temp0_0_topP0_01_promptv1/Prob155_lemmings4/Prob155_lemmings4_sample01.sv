
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
logic state;
always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= 2'b00;
  end else begin
    case (state)
      2'b00: begin // Walk Left
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        if (bump_left)
          state <= 2'b01;
        else if (bump_right)
          state <= 2'b01;
        else if (ground == 0)
          state <= 2'b10;
        else if (dig)
          state <= 2'b01;
      end
      2'b01: begin // Walk Right
        walk_left <= 1'b0;
        walk_right <= 1'b1;
        aaah <= 1'b0;
        digging <= 1'b0;
        if (bump_left)
          state <= 2'b00;
        else if (bump_right)
          state <= 2'b00;
        else if (ground == 0)
          state <= 2'b10;
        else if (dig)
          state <= 2'b00;
      end
      2'b10: begin // Falling
        walk_left <= 1'b0;
        walk_right <= 1'b0;
        aaah <= 1'b1;
        digging <= 1'b0;
        state <= 2'b11;
      end
      2'b11: begin // Falling - Counter
        walk_left <= 1'b0;
        walk_right <= 1'b0;
        aaah <= 1'b1;
        digging <= 1'b0;
        if (ground)
          state <= 2'b00;
        else
          state <= 2'b11;
      end
    endcase
  end
endmodule
