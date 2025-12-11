
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

wire c0, c1, c2, c3, c4;
wire s0, s1, s2, s3;

assign c0 = 1'b0;

// Full adder 1 (LSB)
assign s0 = x[0] ^ y[0] ^ c0;
assign c1 = (x[0] & y[0]) | (x[0] & c0) | (y[0] & c0);

// Full adder 2
assign s1 = x[1] ^ y[1] ^ c1;
assign c2 = (x[1] & y[1]) | (x[1] & c1) | (y[1] & c1);

// Full adder 3
assign s2 = x[2] ^ y[2] ^ c2;
assign c3 = (x[2] & y[2]) | (x[2] & c2) | (y[2] & c2);

// Full adder 4 (MSB)
assign s3 = x[3] ^ y[3] ^ c3;
assign c4 = (x[3] & y[3]) | (x[3] & c3) | (y[3] & c3);

// Assign sum bits including overflow
assign sum[0] = s0;
assign sum[1] = s1;
assign sum[2] = s2;
assign sum[3] = s3;
assign sum[4] = c4; // Overflow bit

endmodule
