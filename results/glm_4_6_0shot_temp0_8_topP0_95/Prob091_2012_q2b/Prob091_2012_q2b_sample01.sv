
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

  // Y1 is the next state for flip-flop y[1] (state B)
  // From state diagram: only A transitions to B when input w = 1
  assign Y1 = y[0] & w;
  
  // Y3 is the next state for flip-flop y[3] (state D)
  // From state diagram: B, C, E, F all transition to D when input w = 0
  assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
