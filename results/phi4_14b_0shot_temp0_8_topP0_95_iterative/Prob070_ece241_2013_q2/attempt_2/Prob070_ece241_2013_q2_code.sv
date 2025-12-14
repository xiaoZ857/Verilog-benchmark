
// Place the `timescale directive at the top of your file, outside any module
`timescale 1ns / 1ps

module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  // Sum-of-Products (SOP) form
  assign out_sop = (~a & ~b & c & ~d) | 
                   (~a & b & c & d) | 
                   (a & b & c & d);

  // Product-of-Sums (POS) form
  assign out_pos = (a | b | c | d) & 
                   (a | b | c | ~d) & 
                   (a | ~b | c | d) & 
                   (a | ~b | c | ~d) & 
                   (a | ~b | ~c | d) & 
                   (~a | b | c | ~d) & 
                   (~a | b | ~c | d) & 
                   (~a | ~b | c | ~d) & 
                   (~a | ~b | ~c | d);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
