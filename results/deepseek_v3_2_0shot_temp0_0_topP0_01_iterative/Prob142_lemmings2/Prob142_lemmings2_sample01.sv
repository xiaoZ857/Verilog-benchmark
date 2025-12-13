
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
  reg [1:0] state, next_state;
  localparam WALK_L = 2'b00,
             WALK_R = 2'b01,
             FALL_L = 2'b10,
             FALL_R = 2'b11;
  
  // State register
  always @(posedge clk, posedge areset) begin
    if (areset) state <= WALK_L;
    else state <= next_state;
  end
  
  // Next state logic
  always @(*) begin
    case (state)
      WALK_L: begin
        if (~ground) next_state = FALL_L;
        else if (bump_left) next_state = WALK_R;
        else next_state = WALK_L;
      end
      WALK_R: begin
        if (~ground) next_state = FALL_R;
        else if (bump_right) next_state = WALK_L;
        else next_state = WALK_R;
      end
      FALL_L: begin
        if (ground) next_state = WALK_L;
        else next_state = FALL_L;
      end
      FALL_R: begin
        if (ground) next_state = WALK_R;
        else next_state = FALL_R;
      end
      default: next_state = WALK_L;
    endcase
  end
  
  // Output logic
  assign walk_left = (state == WALK_L);
  assign walk_right = (state == WALK_R);
  assign aaah = (state == FALL_L) | (state == FALL_R);
endmodule
