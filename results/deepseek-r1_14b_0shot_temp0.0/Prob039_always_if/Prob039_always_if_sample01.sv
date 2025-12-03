

module TopModule (
  input a,
  input b,
  input sel_b1,
  input sel_b2,
  output out_assign,
  output reg out_always
);

out_assign = (sel_b1 & sel_b2) ? b : a;

// VERILOG-EVAL: abnormal backticks count
