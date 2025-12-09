

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);

 ```verilog
reg and1_output, and2_output;

assign and1 = a & b;
assign and2 = c & d;

assign or_output = and1 | and2;
assign out = or_output;
assign out_n = ~or_output;

endmodule

// VERILOG-EVAL: abnormal backticks count
