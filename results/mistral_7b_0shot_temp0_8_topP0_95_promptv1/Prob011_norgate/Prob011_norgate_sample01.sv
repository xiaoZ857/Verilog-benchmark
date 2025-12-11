
module TopModule (
  input a,
  input b,
  output out
);
 ```verilog
assign out = ~(a | b);
endmodule

// VERILOG-EVAL: abnormal backticks count
