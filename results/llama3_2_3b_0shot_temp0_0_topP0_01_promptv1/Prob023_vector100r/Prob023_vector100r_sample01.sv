
module TopModule (
  input [99:0] in,
  output reg [99:0] out
);
assign out = {in[98:0], in[99:1]}; endmodule

// VERILOG-EVAL: endmodule not found
