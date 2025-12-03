

module TopModule (
  input in1,
  input in2,
  output logic out
);

assign out = in1 nor in2;
endmodule
