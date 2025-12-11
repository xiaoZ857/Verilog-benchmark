
module TopModule (
  input a,
  input b,
  input sel,
  output out
);
 ```verilog
assign out = sel ? b : a;
endmodule

// VERILOG-EVAL: abnormal backticks count
