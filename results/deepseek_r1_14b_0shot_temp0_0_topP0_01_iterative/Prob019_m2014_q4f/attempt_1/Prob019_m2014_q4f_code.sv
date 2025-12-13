
module TopModule (
  input in1,
  input in2,
  output logic out
);

  // The AND operation with in2 inverted due to the bubble
  assign out = in1 & !in2;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
