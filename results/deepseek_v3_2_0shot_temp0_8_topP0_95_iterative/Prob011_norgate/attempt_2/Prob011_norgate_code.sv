
module TopModule (
  input a,
  input b,
  output out
);
  out <= ~(a | b);
endmodule
