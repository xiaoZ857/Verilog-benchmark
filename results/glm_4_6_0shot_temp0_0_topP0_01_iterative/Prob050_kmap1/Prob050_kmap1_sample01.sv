
module TopModule (
  input a,
  input b,
  input c,
  output out
);
// Implement the circuit described by the Karnaugh map
// The output is 1 for all combinations except when a=0, b=0, c=0
// This simplifies to: out = a | b | c

assign out = a | b | c;

endmodule
