
module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);
next_state[0] = (~in & state[0]) | (~in & state[2]); // A next: from A (in=0) or C (in=0)
next_state[1] = (in & state[0]) | (in & state[1]) | (in & state[3]); // B next: from A (in=1), B (in=1), or D (in=1)
next_state[2] = (~in & state[1]) | (in & state[2]) | (~in & state[3]); // C next: from B (in=0), C (in=1), or D (in=0)
next_state[3] = (in & state[2]); // D next: from C (in=1)

assign out = state[3]; // Output is 1 only when in state D

endmodule
