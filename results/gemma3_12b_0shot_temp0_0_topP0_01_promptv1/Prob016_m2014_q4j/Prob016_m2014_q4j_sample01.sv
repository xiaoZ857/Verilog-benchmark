
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
assign carry = x[3] & y[3];
assign sum[0] = x[0] ^ y[0];
assign temp1 = x[0] & y[0];
assign sum[1] = sum[0] ^ y[1];
assign temp2 = sum[0] & y[1];
assign sum[2] = sum[1] ^ y[2];
assign temp3 = sum[1] & y[2];
assign sum[3] = sum[2] ^ y[3];
assign temp4 = sum[2] & y[3];
assign sum[4] = temp4 ^ carry;
endmodule
