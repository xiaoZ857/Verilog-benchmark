
module TopModule (
  input [255:0] in,
  input [7:0] sel,
  output  out
);
  out = in[sel];

// VERILOG-EVAL: endmodule not found
