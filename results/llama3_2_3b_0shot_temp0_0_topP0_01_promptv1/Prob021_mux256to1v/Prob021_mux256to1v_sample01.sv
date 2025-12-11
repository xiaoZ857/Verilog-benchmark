
module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);
assign out[3] = in[1023:1020];
assign out[2] = in[1019:1016];
assign out[1] = in[1015:1012];
assign out[0] = in[1011:1008];

// VERILOG-EVAL: endmodule not found
