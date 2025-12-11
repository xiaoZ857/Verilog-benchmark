
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
assign Y2 = (w & ~y) | (y[0] & y[1]); endmodule

// VERILOG-EVAL: endmodule not found
