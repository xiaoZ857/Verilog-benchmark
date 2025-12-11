
module TopModule (
  input x,
  input y,
  output z
);
 ```verilog
assign z = ^(x & y) & x;
endmodule

// VERILOG-EVAL: abnormal backticks count
