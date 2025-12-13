
module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);
  // 100-input AND gate: AND of all bits
  assign out_and = &in;

  // 100-input OR gate: OR of all bits
  assign out_or = |in;

  // 100-input XOR gate: XOR of all bits (parity)
  assign out_xor = ^in;

endmodule
