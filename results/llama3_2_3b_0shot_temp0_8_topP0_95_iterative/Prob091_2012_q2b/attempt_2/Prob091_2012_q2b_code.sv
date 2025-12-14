
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);
Y1 = (~w & y[5]) | (w & y[4]);
Y3 = (~w & y[0]) | (w & ~y[2]);

// VERILOG-EVAL: endmodule not found
