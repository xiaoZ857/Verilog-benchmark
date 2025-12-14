
module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);
next_state[0] = (~in & state[0]) | (~in & state[2]);
next_state[1] = (in & state[0]) | (in & state[1]) | (in & state[3]);
next_state[2] = (~in & state[1]) | (in & state[2]) | (~in & state[3]);
next_state[3] = (in & state[2]);

assign out = state[3];

endmodule
