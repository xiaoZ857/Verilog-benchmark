
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
assign Y2 = (w & ~y) | (~w & y[0]); endmodule

// VERILOG-EVAL: endmodule not found
