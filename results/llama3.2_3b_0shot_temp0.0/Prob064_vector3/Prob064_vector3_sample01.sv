

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

// Concatenate the input vectors and add two 1 bits at the end
assign w = {a, b, c, d, e, f, 1'b1, 1'b1};

// Split the concatenated vector into four parts of 8 bits each
assign x = {a[4:0], b[4:0], c[4:0], d[4:0]};
assign y = {e[4:0], f[4:0], 1'b1, 1'b1};
assign z = {b[4:0], a[4:0], c[4:0], d[4:0]};

// VERILOG-EVAL: endmodule not found
