
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);
// Half Adder module
assign sum = a ^ b;  // XOR operation for half adder
assign cout = ((a & b) != 0);  // AND operation with non-zero value to get carry-out

// VERILOG-EVAL: endmodule not found
