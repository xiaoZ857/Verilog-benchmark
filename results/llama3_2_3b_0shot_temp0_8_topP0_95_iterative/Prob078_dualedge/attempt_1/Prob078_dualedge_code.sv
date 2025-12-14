
module TopModule (
  input clk,
  input d,
  output reg q
);

reg prev_q;

assign prev_q = q;
assign q = (d & ~prev_q) | (~d & prev_q);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
