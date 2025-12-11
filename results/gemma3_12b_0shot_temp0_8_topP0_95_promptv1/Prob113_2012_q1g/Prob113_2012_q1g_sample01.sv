
module TopModule (
  input [4:1] x,
  output logic f
);
always @(*) begin
  if (x[1] == 1 && x[2] == 1 && x[3] == 1)
    f = ~x[4];
  else if (x[1] == 0 && x[2] == 0 && x[3] == 0)
    f = x[4];
  else
    f = 1'b0;
endmodule
