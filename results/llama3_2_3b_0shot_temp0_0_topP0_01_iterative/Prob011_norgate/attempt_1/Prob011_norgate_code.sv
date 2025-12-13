
module TopModule (
  input a,
  input b,
  output out
);
// Define the inputs and outputs of the module
input a, b;
output out;

// Implement the NOR gate logic
assign out = ~ (a & b);

endmodule
