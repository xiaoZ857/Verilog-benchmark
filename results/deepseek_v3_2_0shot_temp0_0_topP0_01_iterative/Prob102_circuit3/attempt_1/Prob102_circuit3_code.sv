
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = (b & d) | (c & d) | (a & d) | (b & c);

// VERILOG-EVAL: endmodule not found
