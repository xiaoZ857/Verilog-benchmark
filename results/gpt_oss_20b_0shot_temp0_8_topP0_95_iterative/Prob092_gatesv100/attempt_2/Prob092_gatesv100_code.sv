
module TopModule (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
  // (1) Both left neighbour and self are 1
  assign out_both = in[98:0] & in[99:1];

  // (2) Either left neighbour or self is 1 (right neighbour in the problem statement)
  assign out_any  = in[99:1] | in[98:0];

  // (3) Self is different from left neighbour (wrap‑around)
  assign out_different = in ^ {in[0], in[99:1]};

// VERILOG-EVAL: endmodule not found
