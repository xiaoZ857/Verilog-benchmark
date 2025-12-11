
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
assign sum = a | b | cin;
assign cout = a & b & ~cin;

// VERILOG-EVAL: endmodule not found
