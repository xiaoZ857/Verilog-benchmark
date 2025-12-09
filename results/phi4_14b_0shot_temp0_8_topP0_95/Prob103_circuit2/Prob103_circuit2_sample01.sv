
module TopModule (
    input a,
    input b,
    input c,
    input d,
    output q
);

  // Calculate the parity (XOR) of all inputs to get the output q.
  assign q = a ^ b ^ c ^ d;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
