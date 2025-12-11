
module TopModule (
  input a,
  input b,
  output q
);
assign q = (a == 1) && (b == 1);
endmodule
