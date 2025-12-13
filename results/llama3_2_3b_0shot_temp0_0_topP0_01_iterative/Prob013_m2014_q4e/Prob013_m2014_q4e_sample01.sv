
module TopModule (
  input in1,
  input in2,
  output logic out
);
assign out = ~(in1 & in2);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
