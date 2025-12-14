
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

  // Looking at the waveform data, I need to determine the logic function.
  // Let me analyze the truth table:
  // a b c d | q
  // 0 0 0 0 | 0
  // 0 0 0 1 | 0
  // 0 0 1 0 | 1
  // 0 0 1 1 | 1
  // 0 1 0 0 | 1
  // 0 1 0 1 | 1
  // 0 1 1 0 | 1
  // 0 1 1 1 | 1
  // 1 0 0 0 | 0
  // 1 0 0 1 | 0
  // 1 0 1 0 | 1
  // 1 0 1 1 | 1
  // 1 1 0 0 | 1
  // 1 1 0 1 | 1
  // 1 1 1 0 | 1
  // 1 1 1 1 | 1
  
  // Looking at the pattern, q = 0 only when b = 0 AND c = 0
  // In all other cases, q = 1
  // This is the logical OR operation between b and c
  // q = b OR c
  
  assign q = b | c;
  
endmodule
