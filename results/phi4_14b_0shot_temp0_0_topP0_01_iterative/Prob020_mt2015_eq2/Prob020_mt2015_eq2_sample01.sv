
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
);

  // Assign the output based on the comparison of A and B
  assign z = (A == B) ? 1'b1 : 1'b0;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
