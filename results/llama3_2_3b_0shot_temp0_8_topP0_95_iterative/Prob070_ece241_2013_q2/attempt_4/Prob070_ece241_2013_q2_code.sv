
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);
assign out_sop = (a|b|c) & (~a|~b|~c) | ((a&b)&(c&d)) | ((a&c)&(b&d)) | ((a&d)&(b&c));

assign out_pos = ~(a^b^c) & ~(a^b^d) & ~(a^c^d) | (a|b|c) & (~a|~b|~c) | ~((a&b)&(c&d)) | ~((a&c)&(b&d)) | ~((a&d)&(b&c));

// VERILOG-EVAL: endmodule not found
