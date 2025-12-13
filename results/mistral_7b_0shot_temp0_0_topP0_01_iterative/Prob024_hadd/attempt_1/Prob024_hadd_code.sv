
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);
module HalfAdder (
  input wire a,
  input wire b,
  output wire sum,
  output wire cout
);

// Internal signals
wire xor_result;

// XOR gate for sum calculation
xor #1 xor_result (a, b);

// Assign outputs based on internal signal
assign sum = xor_result;
assign cout = a & b; // AND gate implicitly created by the assignment

endmodule
