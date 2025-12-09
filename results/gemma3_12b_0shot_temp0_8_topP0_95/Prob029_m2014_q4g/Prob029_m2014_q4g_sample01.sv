
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);

  logic xnor_out;

  // Two-input XNOR
  assign xnor_out = ~(in1 ^ in2);

  // Two-input XOR
  assign out = xnor_out ^ in3;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
