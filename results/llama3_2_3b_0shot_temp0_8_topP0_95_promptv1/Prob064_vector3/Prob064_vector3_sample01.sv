
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
assign w = {a, b, c, d, e, f[1:0], 1'b1};
assign x = {f[3:0], f[2:1], 1'b1, 1'b0};
assign y = {c[4:1], a[4:1], b[4:1], f[4:1]};
assign z = {a[3:1], b[3:1], c[3:1], d[3:1], e[3:1]};

// VERILOG-EVAL: endmodule not found
