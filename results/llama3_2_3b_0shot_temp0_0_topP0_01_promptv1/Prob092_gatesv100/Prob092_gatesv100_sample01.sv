
module TopModule (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);
assign out_both[98:0] = (in[98] & in[99]) | (in[97] & in[98]);
assign out_any[2:0] = (in[2] | in[1]) | (in[3] | in[2]);
assign out_different[98:0] = (in[98] ^ in[99]) | (in[0] ^ in[1]);

// VERILOG-EVAL: endmodule not found
