
module TopModule (
  input in1,
  input in2,
  output logic out
);
  out = ~(in1 | in2);

// VERILOG-EVAL: endmodule not found
