
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
assign out = {in, in[1], in[2], in[3]};

// VERILOG-EVAL: endmodule not found
