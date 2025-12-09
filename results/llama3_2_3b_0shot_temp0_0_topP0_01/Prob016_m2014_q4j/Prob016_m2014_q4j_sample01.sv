

module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

assign sum = ((x[2] & ~y[2]) | (x[1] & y[1])) ? 1 : 0;
sum[2] <= x[2] ^ y[2];
sum[3] <= x[3] ^ y[3];
sum[4] <= x[4] ^ y[4];
assign sum[1] = (x[0] & ~y[0]) | (x[0] & y[0]);

// VERILOG-EVAL: endmodule not found
