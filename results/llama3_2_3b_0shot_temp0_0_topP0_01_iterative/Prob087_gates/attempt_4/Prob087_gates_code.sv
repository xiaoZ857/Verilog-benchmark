
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
assign out_xnor = !(!a & !b);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
