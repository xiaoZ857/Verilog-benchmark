
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);
  assign Y2 = (y[1] == 1);  // Y2 is high when state is B

  assign Y4 = (y[3] == 1);  // Y4 is high when state is D

// VERILOG-EVAL: endmodule not found
