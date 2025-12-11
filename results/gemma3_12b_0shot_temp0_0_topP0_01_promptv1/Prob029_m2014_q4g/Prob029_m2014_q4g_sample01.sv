
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);
assign xnor_out = in1 == in2;
always @(xnor_out, in3) begin
  out = xnor_out ^ in3;
endmodule
