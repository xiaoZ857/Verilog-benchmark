
module TopModule (
  input a,
  input b,
  input sel,
  output out
);

  // When sel=0, choose a; when sel=1, choose b
  assign out = (sel == 0) ? a : b;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
