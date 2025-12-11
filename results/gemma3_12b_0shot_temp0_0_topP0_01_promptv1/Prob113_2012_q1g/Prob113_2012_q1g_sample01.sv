
module TopModule (
  input [4:1] x,
  output logic f
);
always @(*) begin
  if ((x[1] == 1 && x[2] == 0 && x[3] == 0) || (x[1] == 0 && x[2] == 0 && x[3] == 1))
    f = 1;
  else
    f = 0;
endmodule
