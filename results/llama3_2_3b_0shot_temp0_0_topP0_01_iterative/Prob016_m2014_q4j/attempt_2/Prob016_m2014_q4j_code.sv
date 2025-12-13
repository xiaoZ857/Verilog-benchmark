
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
// Define the full adder logic
reg [1:0] carry;
reg [2:0] sum_bit;

// Full Adder logic for each bit position
assign sum_bit[0] = x[0] + y[0];
carry[0] <= 1'b1; // Carry from first bit addition

assign sum_bit[1] = (x[1] & carry[0]) ^ (y[1] & ~carry[0]);
carry[1] <= (x[1] & carry[0]) | (y[1] & ~carry[0]);

assign sum_bit[2] = (x[2] & carry[1]) ^ (y[2] & ~carry[1]);
carry[2] <= (x[2] & carry[1]) | (y[2] & ~carry[1]);

// Calculate the final sum and overflow
assign sum[0] = x[3] + y[3];
assign sum[1:2] = sum_bit[1:0];
assign sum[3] = carry[2];
assign sum[4] = 1'b1; // Overflow bit

endmodule
