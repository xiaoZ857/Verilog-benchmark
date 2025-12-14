
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

// Implement next-state logic for Y2 and Y4 based on one-hot state encoding
// Y2 is the next state signal for state B (y[2])
// Y4 is the next state signal for state D (y[4])

// Y2 = 1 when transitioning to state B
// From state A with input w=0
assign Y2 = y[1] & ~w;

// Y4 = 1 when transitioning to state D
// From state B with input w=1
// From state C with input w=1  
// From state E with input w=1
// From state F with input w=1
assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w);

endmodule
