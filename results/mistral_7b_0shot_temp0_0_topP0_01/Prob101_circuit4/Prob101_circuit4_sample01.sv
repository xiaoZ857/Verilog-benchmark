
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);

assign q = (!a && !b && !c && !d) || ((!a && !b && !c && d) && ((!a && b) || (a && !b && c))) || ((!a && b && c && d) && ((!b && c) || (b && !c && d)));

endmodule

// VERILOG-EVAL: errant inclusion of module definition
