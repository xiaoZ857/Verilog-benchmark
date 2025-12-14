
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);
assign Y2 = (y[1] & ~w); // A -> B when w = 0

assign Y4 = 
    (y[2] & w) |   // B -> D when w = 1
    (y[3] & w) |   // C -> D when w = 1
    (y[5] & ~w) |  // E -> D when w = 0
    (y[6] & w);    // F -> D when w = 1

endmodule
