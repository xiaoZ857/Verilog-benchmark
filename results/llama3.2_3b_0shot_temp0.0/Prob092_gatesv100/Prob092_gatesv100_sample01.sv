

module TopModule (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

assign out_both = (in[99] & in[0]);
assign out_any[2:0] = {in[2], in[1], in[0]};
assign out_any[1:0] = {in[1] | in[2], in[0] | in[1]};
assign out_different[98:0] = (in[99] ^ in[0]);
assign out_different[1:0] = {in[1] ^ in[2], in[0] ^ in[1]};

// VERILOG-EVAL: endmodule not found
