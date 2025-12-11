
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
 ```verilog
assign q = (~a & ~b) | (~c & d);
endmodule

// VERILOG-EVAL: abnormal backticks count
