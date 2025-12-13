
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);
assign Y1 = (~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & y[0] & w);  // From A to B when w=1

assign Y3 = (~y[5] & ~y[4] & ~y[3] & ~y[2] & y[1] & ~y[0] & ~w) |  // From B to D when w=0
            (~y[5] & ~y[4] & ~y[3] & y[2] & ~y[1] & ~y[0] & ~w) |  // From C to D when w=0
            (~y[5] & y[4] & ~y[3] & ~y[2] & ~y[1] & ~y[0] & ~w) |  // From E to D when w=0
            (y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & ~y[0] & ~w);   // From F to D when w=0
endmodule
