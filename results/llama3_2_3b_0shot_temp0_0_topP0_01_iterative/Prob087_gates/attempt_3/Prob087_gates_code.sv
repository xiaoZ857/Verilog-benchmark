
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
assign out_and = a & b; // AND operation

assign out_or = a | b; // OR operation

assign out_xor = !a & !b; // Logical XOR operation using NOT and AND gates

assign out_nand = !(a & b); // NAND operation implemented using NOT and AND gates

assign out_nor = !(a | b); // NOR operation implemented using NOT and OR gates

assign out_xnor = (a ^ b); // Bitwise XOR operation, but we need to implement logical XOR

// To implement logical XOR, we can use the following trick:
assign out_xnor = !(!a & !b);

assign out_anotb = a & !(b); // AND operation with NOT B

// VERILOG-EVAL: endmodule not found
