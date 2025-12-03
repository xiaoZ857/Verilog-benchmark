

module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);

assign out = ~((in1 == in2) ? 1 : 0) ^ in3;
endmodule
