
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  // Define the truth table based on the description
  // 2: a=1, b=0, c=0, d=0  (a=1)
  // 7: a=0, b=1, c=1, d=1  (a'b c d)
  // 15: a=1, b=1, c=1, d=1 (abc d)
  // 0: a=0, b=0, c=0, d=0
  // 1: a=1, b=0, c=0, d=0
  // 4: a=0, b=1, c=0, d=0
  // 5: a=0, b=1, c=0, d=1
  // 6: a=0, b=1, c=1, d=0
  // 9: a=0, b=0, c=1, d=1
  // 10: a=0, b=0, c=1, d=0
  // 13: a=1, b=0, c=0, d=1
  // 14: a=1, b=0, c=1, d=1

  // Sum-of-Products (SOP) form
  assign out_sop = (a & b' & c' & d' ) |  (a' & b & c & d) | (a & b & c & d);


  // Product-of-Sums (POS) form
  assign out_pos = (a' | b' | c' | d') & (a' | b' | c' | d') & (a' | b' | c' | d');
  // Simplified POS form:
  // out_pos = (a' | b' | c' | d') & (a' | b' | c' | d') & (a' | b' | c' | d');
  // out_pos = (a' | b' | c' | d')
  //
  // Consider the truth table, only when the number appears in the inputs we output 1.
  // So, we can write the POS as follows:
  // out_pos = (2 not appear) & (7 not appear) & (15 not appear)
  // out_pos = (a' | b | c | d) & (a | b' | c' | d') & (a' | b' | c' | d')

  // The above simplification is incorrect. We must consider all input combinations.
  // Correct POS implementation:
  assign out_pos = (! (a' & b' & c' & d') & ! (a' & b & c & d) & ! (a & b & c & d));


endmodule

// VERILOG-EVAL: errant inclusion of module definition
