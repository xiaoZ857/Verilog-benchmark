
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
);
wire eq;
assign eq = (A == B);
assign z = eq;
endmodule
