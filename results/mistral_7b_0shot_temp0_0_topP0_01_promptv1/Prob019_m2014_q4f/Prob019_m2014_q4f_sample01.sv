
module TopModule (
  input in1,
  input in2,
  output logic out
);
 ```verilog
assign out = in1 & !in2;
endmodule

// VERILOG-EVAL: abnormal backticks count
