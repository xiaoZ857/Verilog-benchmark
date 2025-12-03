

module TopModule (
  input a,
  input b,
  output sum,
  output cout
);

sum = (a != b);
cout = a & b;

// VERILOG-EVAL: endmodule not found
