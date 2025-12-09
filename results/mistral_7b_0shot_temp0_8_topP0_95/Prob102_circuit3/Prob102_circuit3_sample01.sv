
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

assign abc_majority = (a & b & c) || ((~a) & b & c) || (a & ~b & c) || (a & b & ~c);
assign abcd_majority = (abc_majority & d) || (abc_majority & ~d);
assign q = abcd_majority;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
