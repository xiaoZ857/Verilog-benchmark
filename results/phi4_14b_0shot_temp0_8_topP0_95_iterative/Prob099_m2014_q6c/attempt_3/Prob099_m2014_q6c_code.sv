
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);
assign Y2 = y[1] & ~w;

// VERILOG-EVAL: abnormal backticks count
