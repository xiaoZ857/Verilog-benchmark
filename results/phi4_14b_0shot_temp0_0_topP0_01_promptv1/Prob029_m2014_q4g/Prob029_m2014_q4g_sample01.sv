
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);
always @(*) begin
    wire xnor_out;
    assign xnor_out = ~(in1 ^ in2);
    out = xnor_out ^ in3;
end
endmodule
