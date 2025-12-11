
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
assign sum = a + b;
assign cout = a & b | cin;

endmodule
