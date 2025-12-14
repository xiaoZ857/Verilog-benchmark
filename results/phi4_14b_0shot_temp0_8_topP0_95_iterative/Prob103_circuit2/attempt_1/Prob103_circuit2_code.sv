
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

  assign q = a ^ b ^ c ^ d; // XOR operation to determine odd number of 1s

endmodule

// VERILOG-EVAL: errant inclusion of module definition
