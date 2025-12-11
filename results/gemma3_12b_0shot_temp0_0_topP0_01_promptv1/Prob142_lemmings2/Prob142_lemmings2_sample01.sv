
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
logic state;
assign walk_left = state == 2'b00;
assign walk_right = state == 2'b01;
assign aaah = state == 2'b10;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= 2'b00;
  end else begin
    case (state)
      2'b00: begin
        if (bump_left)
          state <= 2'b01;
        else if (bump_right)
          state <= 2'b00;
        else if (ground)
          state <= 2'b10;
        else
          state <= 2'b00;
      end
      2'b01: begin
        if (bump_left)
          state <= 2'b00;
        else if (bump_right)
          state <= 2'b01;
        else if (ground)
          state <= 2'b10;
        else
          state <= 2'b01;
      end
      2'b10: begin
        if (ground)
          state <= state;
        else
          state <= 2'b10;
      end
      default: state <= 2'b00;
    endcase
  end
endmodule
