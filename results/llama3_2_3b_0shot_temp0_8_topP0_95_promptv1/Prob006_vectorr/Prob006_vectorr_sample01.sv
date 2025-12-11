
module TopModule (
  input [7:0] in,
  output [7:0] out
);
assign out = {in[6:], in[5:0]}; endmodule

// VERILOG-EVAL: endmodule not found
