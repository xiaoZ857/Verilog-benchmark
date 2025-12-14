
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
                   (~a |

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
