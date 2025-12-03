
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

reg [1:0] state;
reg [1:0] prev_state;
reg [1:0] fall_count;

assign walk_left = (state == 2'b00) ? 1'b0 : (state == 2'b01) ? 1'b1 : (dig && ground == 1) ? 1'b1 : 1'b0;
assign walk_right = (state == 2'b00) ? 1'b1 : (state == 2'b01) ? 1'b0 : (dig && ground == 1) ? 1'b0 : 1'b1;

always @(posedge clk or negedge areset)
begin
  if (!areset)
    state <= 2'b00;
  else
    state <= prev_state;
end

assign fall_count = (ground == 0) ? fall_count + 1 : 0;

always @(posedge clk or negedge ground)
begin
  if ((ground == 0) && (fall_count > 20))
    state <= 2'b10; // splatter
  else if (ground == 1)
    state <= prev_state;
end

assign aaah = (state == 2'b00) || (state == 2'b01);

always @(posedge clk or negedge bump_left or negedge bump_right)
begin
  if ((bump_left && !dig) || (bump_right && !dig))
    state <= prev_state;
end

assign digging = dig && ground == 1;

assign prev_state = state;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
