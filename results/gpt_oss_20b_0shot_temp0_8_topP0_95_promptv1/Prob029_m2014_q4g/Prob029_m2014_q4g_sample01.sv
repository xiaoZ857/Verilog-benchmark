
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);
logic temp;

always @(*) begin
    temp = ~(in1 ^ in2);
    out  = temp ^ in3;
end
endmodule
