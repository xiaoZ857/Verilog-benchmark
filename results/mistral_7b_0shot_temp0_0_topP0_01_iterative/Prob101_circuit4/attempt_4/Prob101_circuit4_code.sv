
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = (a | b | c | d) ^ (c & (~a & ~b & ~d));

// VERILOG-EVAL: endmodule not found
