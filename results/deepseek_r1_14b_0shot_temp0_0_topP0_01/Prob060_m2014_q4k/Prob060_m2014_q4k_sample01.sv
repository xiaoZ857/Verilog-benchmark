
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
    // Flip flop declarations
    D_ff ff1 (clk, resetn, in, ff2.D);
    D_ff ff2 (clk, resetn, ff1.Q, ff3.D);
    D_ff ff3 (clk, resetn, ff2.Q, ff4.D);
    D_ff ff4 (clk, resetn, ff3.Q, out);

endmodule

// VERILOG-EVAL: errant inclusion of module definition
