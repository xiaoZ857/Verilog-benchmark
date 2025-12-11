
module TopModule (
  input [4:0] a,
  input [4:0] b,
  input [4:0] c,
  input [4:0] d,
  input [4:0] e,
  input [4:0] f,
  output [7:0] w,
  output [7:0] x,
  output [7:0] y,
  output [7:0] z
);
assign {w, x, y[7], y[6:0]} = {f, e, d, c, b, a};
assign z = 8'b11;
endmodule
