
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = ~(d & c) | (d & ~c);

// VERILOG-EVAL: abnormal backticks count
