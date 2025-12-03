

module TopModule (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

wire signed [8:0] sum; // Extend to 9 bits to capture potential overflow

assign sum = a + b;

assign s = sum[7:0]; // Take the lower 8 bits as the result

// Overflow detection for two's complement addition:
// Overflow occurs if the sign of the result is different from both inputs
assign overflow = (a[7] & b[7] & ~sum[7]) | (~a[7] & ~b[7] & sum[7]);

endmodule
