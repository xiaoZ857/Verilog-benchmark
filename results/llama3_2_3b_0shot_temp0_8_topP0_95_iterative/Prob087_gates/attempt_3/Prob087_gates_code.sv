
assign out_nor = ~(a | b);
assign out_xnor = ~a & ~b;
assign out_nand = ~(a | b); // Corrected implementation of NAND gate

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
