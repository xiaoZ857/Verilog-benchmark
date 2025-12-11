
module TopModule (
  input [99:0] a,
  input [99:0] b,
  input sel,
  output [99:0] out
);
 ```verilog
assign out = sel & a + ~sel & b;
endmodule

// VERILOG-EVAL: abnormal backticks count
