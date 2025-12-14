
module TopModule (
  input a,
  input b,
  input c,
  output out
);
// Continuous assignment implementing the Karnaugh‑map logic
assign out = a | b | c;

endmodule
