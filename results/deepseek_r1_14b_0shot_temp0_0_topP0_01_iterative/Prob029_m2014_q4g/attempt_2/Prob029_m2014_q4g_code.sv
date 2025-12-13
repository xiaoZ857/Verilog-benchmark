
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);

  // Calculate XNOR of in1 and in2
  logic xnor_out;
  xnor_out = (in1 == in2);
  
  // XOR the XNOR result with in3 to get the final output
  out = xnor_out ^ in3;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
