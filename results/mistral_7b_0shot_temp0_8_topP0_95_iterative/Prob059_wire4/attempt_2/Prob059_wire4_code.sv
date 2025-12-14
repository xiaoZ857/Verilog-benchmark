
module TopModule;
  input a, b, c;
  output reg w, x, y, z;

  regassign w = a;
  regassign x = b;
  regassign y = b;
  regassign z = c;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
