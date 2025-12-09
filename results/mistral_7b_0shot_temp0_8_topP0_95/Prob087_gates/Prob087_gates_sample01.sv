
module TopModule (
  input a,
  input b,
  output reg out_and,
  output reg out_or,
  output reg out_xor,
  output reg out_nand,
  output reg out_nor,
  output reg out_xnor,
  output reg out_anotb
);

assign out_and = a & b; // AND gate
assign out_or = a | b; // OR gate
assign out_xor = a ^ b; // XOR gate
assign out_nand = ~(a & b); // NAND gate with negative edge trigger
assign out_nor = ~(a | b); // NOR gate with negative edge trigger
assign out_xnor = ~(a ^ b); // XNOR gate with negative edge trigger
assign out_anotb = a & ~b; // AND gate with NOT on the second input

endmodule

// VERILOG-EVAL: errant inclusion of module definition
