
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);
// Half Adder module
module HalfAdder(
  input a,        // input bit A
  input b,        // input bit B
  output sum,     // output sum (bit)
  output cout     // output carry-out (bit)
);

// Assign signals to output sum and carry_out 
assign sum = a ^ b;  // XOR operation for half adder
assign cout = ((a & b) == 0);  // AND operation with complement of sum

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
