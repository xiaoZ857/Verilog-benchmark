
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);
always @(*) begin
    Y1 = (~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & ~y[0] & w) | (~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & y[0] & ~w);
end

always @(*) begin
    Y3 = (~y[5] & ~y[4] & ~y[3] & ~y[2] & y[1] & ~y[0] & ~w) | (~y[5] & ~y[4] & ~y[3] & y[2] & ~y[1] & ~y[0] & ~w) | (~y[5] & ~y[4] & y[3] & ~y[2] & ~y[1] & ~y[0] & ~w) | (~y[5] & y[4] & ~y[3] & ~y[2] & ~y[1] & ~y[0] & ~w) | (y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & ~y[0] & ~w);
end

endmodule
