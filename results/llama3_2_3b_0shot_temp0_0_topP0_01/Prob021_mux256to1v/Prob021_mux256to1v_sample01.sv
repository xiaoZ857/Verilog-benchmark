

module TopModule (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

assign out = {in[11:8], in[7:4], in[5:2], in[1:0]};

// VERILOG-EVAL: endmodule not found
