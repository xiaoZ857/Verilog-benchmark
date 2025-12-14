
module TopModule (
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  output p1y,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p2y
);
module nand_gate (
    input a,
    input b,
    input c,
    input d,
    output y
);

    assign y = ~(a & b & c & d);

endmodule

module TopModule (
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

    nand_gate nand1 (p1a, p1b, p1c, p1d, p1y);
    nand_gate nand2 (p2a, p2b, p2c, p2d, p2y);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
