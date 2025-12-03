

module TopModule (
  input a,
  input b,
  output q
);

always_comb
    q = a & b;
endmodule
