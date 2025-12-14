
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
q <= {data, q[3:1]};  // This puts data into LSB and shifts left

// VERILOG-EVAL: abnormal backticks count
