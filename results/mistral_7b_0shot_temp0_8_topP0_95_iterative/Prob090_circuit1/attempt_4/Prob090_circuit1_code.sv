
module TopModule (
  input a,
  input b,
  output q
);
assign q = (~a & ~b) | (a & b);

// VERILOG-EVAL: abnormal backticks count
