
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
// Instance of 4-input NAND gate for inputs p1a, p1b, p1c, p1d
nand4 #(.N(4)) nand_gate1 (p1a, p1b, p1c, p1d, p1y);

// Instance of 4-input NAND gate for inputs p2a, p2b, p2c, p2d
nand4 #(.N(4)) nand_gate2 (p2a, p2b, p2c, p2d, p2y);

// Assign output y of each NAND gate to its respective output pin in TopModule
assign p1y = ! (p1a && p1b && p1c && p1d);
assign p2y = ! (p2a && p2b && p2c && p2d);

// VERILOG-EVAL: endmodule not found
