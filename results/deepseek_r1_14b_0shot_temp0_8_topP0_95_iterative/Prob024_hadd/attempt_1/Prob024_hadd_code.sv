
module TopModule (
  input a,
  input b,
  output sum,
  output cout
);

// Implementing the half adder logic
assign sum = a ^ b;    // XOR gives the sum without carry
assign cout = a & b;   // AND gives the carry-out

endmodule

// VERILOG-EVAL: errant inclusion of module definition
