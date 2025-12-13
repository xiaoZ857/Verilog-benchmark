
module TopModule (
  input a,
  input b,
  input sel,
  output out
);
  out = sel ? b : a;
endmodule
