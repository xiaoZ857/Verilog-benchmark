
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

  // Y2 corresponds to bit 2 of the one-hot encoding.
  // It is 1 when the state is B.
  assign Y2 = (y[2] == 1);

  // Y4 corresponds to bit 4 of the one-hot encoding.
  // It is 1 when the state is D.
  assign Y4 = (y[4] == 1);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
