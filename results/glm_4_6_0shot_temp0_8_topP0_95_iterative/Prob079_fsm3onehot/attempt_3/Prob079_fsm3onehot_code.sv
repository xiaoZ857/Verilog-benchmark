
module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);

always @(*) begin
  // Next state logic
  next_state[0] = (state[0] & ~in) | (state[2] & ~in);  // A from A when in=0, or from C when in=0
  next_state[1] = (state[0] & in) | (state[1] & in) | (state[3] & in);  // B from A when in=1, from B when in=1, or from D when in=1
  next_state[2] = (state[1] & ~in) | (state[3] & ~in);  // C from B when in=0, or from D when in=0
  next_state[3] = state[2] & in;  // D from C when in=1
end

// Output logic (Moore machine - output depends only on current state)
assign out = state[3];  // Output is 1 only in state D

endmodule
