
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
assign out_nand = (a & b); // NAND gate
assign out_xor = (a ^ b); // XOR gate (no need to negate the output)

// VERILOG-EVAL: abnormal backticks count
