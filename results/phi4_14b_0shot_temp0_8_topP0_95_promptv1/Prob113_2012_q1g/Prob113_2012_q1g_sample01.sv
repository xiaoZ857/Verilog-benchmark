
module TopModule (
  input [4:1] x,
  output logic f
);
assign f = (x[1] == 1'b0 && x[2] == 1'b0 && (x[3] == 1'b0 || x[4] == 1'b0)) ||
           (x[1] == 1'b1 && x[2] == 1'b1) ||
           (x[1] == 1'b1 && x[2] == 1'b0 && (x[3] == 1'b0 || x[4] == 1'b0)) ||
           (x[1] == 1'b0 && x[2] == 1'b1 && x[3] == 1'b1) ||
           (x[1] == 1'b0 && x[2] == 1'b1 && x[4] == 1'b1);
endmodule
