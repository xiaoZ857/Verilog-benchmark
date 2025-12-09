
module TopModule (
  input a,
  input b,
  output out_and,
  output out_or,
  output out_xor,
  output out_nand,
  output out_nor,
  output out_xnor,
  output out_anotb
);
  
  // Assign each output based on the respective logic operation
  assign out_and   = a & b;       // AND gate
  assign out_or    = a | b;       // OR gate
  assign out_xor   = a ^ b;       // XOR gate
  assign out_nand  = ~(a & b);    // NAND gate (inverted AND)
  assign out_nor   = ~(a | b);    // NOR gate (inverted OR)
  assign out_xnor  = ~(a ^ b);    // XNOR gate (inverted XOR)
  assign out_anotb = a & ~b;      // AND with NOT on b

endmodule

// VERILOG-EVAL: errant inclusion of module definition
