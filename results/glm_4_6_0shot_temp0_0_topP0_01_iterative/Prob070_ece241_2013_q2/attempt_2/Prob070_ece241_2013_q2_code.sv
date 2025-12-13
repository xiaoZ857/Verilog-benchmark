
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

// For out_sop (sum of products), we need to output 1 for minterms 2, 7, 15
// and can use don't cares 3, 8, 11, 12 for minimization
// Minterms: 2(0010), 7(0111), 15(1111)
// Don't cares: 3(0011), 8(1000), 11(1011), 12(1100)
// Simplified SOP: bcd + a'cd'

assign out_sop = (b & c & d) | (~a & c & ~

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
