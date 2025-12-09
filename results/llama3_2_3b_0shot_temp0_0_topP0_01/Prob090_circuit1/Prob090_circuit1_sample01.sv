

module TopModule (
  input a,
  input b,
  output q
);

assign q = (a == 0 && b == 0) || (a == 1 && b == 1);
endmodule
