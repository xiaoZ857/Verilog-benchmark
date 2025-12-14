
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
);

wire z;

assign z = (A | B) == (A & B);  // z is 1 only when both A and B are equal

endmodule

// VERILOG-EVAL: errant inclusion of module definition
