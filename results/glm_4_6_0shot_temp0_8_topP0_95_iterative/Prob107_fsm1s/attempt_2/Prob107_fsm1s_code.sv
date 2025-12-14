
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

// State encoding
parameter A = 1'b0;
parameter B = 1'b1;

reg state_reg, next_state;

always @(posedge clk) begin
  if (reset)
    state_reg <= B;  // Reset to state B
  else
    state_reg <= next_state;
end

// Next state logic
always @(*) begin
  case (state_reg)
    A: begin
      if (in)
        next_state = A;
      else
        next_state = B;
    end
    B: begin
      if (in)
        next_state = B;
      else
        next_state = A;
    end
    default: next_state = B;
  endcase
end

// Output logic (Moore machine - output depends only on state)
assign out = state_reg;

endmodule
