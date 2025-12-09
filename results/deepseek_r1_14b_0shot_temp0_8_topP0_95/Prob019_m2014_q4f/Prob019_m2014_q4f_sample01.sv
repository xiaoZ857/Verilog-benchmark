
module TopModule (
  input in1,
  input in2,
  output logic out
);

  // Invert in2 and apply AND with in1
  assign out = in1 & (~in2);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
