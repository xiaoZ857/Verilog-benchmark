
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
assign sum[3] = (x[2] & y[2]) | ((x[1] & y[1]) | ((x[0] & y[0]) | (x[0] & y[1]) | (x[1] & y[0])));
assign sum[2] = (x[2] & y[1]) | ((x[1] & y[0]) | (x[0] & y[2]));
assign sum[1] = (x[1] & y[2]) | ((x[0] & y[1]) | (x[0] & y[0]));
assign sum[0] = x[0] & y[3] | x[1] & y[2] | x[2] & y[1];

// VERILOG-EVAL: endmodule not found
