
module TopModule (
  input a,
  input b,
  input c,
  input d,
  input e,
  output [24:0] out
);

  // Compute all 25 pairwise comparisons
  // out[24] through out[20]: a compared with a,b,c,d,e
  assign out[24] = ~a ^ a;
  assign out[23] = ~a ^ b;
  assign out[22] = ~a ^ c;
  assign out[21] = ~a ^ d;
  assign out[20] = ~a ^ e;
  
  // out[19] through out[15]: b compared with a,b,c,d,e
  assign out[19] = ~b ^ a;
  assign out[18] = ~b ^ b;
  assign out[17] = ~b ^ c;
  assign out[16] = ~b ^ d;
  assign out[

// VERILOG-EVAL: endmodule not found
