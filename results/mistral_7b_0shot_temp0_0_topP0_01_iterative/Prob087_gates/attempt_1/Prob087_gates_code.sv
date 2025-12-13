
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

assign out_and = a & b; // AND gate
assign out_or = a | b; // OR gate
assign out_xor = a ^ b; // XOR gate
assign out_nand = ~(a & b); // NAND gate using De Morgan's law
assign out_nor = ~(a | b); // NOR gate using De Morgan's law
assign out_xnor = ~(a ^ b) & (a | b); // XNOR gate using De Morgan's law and the fact that xnor is equal to not(xor) and not(xor) = (not(x) nor not(y))
assign out_anotb = a & ~b; // AND-NOT gate

endmodule

// VERILOG-EVAL: errant inclusion of module definition
