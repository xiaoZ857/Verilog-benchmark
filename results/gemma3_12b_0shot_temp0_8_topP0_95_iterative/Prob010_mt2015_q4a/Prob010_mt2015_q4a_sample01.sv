
module TopModule (
  input x,
  input y,
  output z
);

  assign z = (x ^ y) & x;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
