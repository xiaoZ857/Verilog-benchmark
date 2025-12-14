
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

assign Y2 = (y[1] & ~w) | (y[3] & ~w);
assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[6] & w);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
