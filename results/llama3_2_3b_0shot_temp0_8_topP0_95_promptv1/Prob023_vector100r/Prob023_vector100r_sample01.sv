
module TopModule (
  input [99:0] in,
  output reg [99:0] out
);
assign out[98:0] = in[99:0][1:0];

// VERILOG-EVAL: endmodule not found
