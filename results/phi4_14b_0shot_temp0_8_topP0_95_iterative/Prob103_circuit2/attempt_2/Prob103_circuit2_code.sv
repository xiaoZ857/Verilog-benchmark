
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

  // XOR operation to determine odd number of 1s
  assign q = a ^ b ^ c ^ d;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
