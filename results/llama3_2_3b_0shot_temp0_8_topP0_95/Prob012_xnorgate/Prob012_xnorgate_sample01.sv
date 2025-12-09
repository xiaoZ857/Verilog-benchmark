
module TopModule (
  input a,
  input b,
  output out
);

// Implement XOR using NOT and AND
assign out = (~a & ~b) | 
             ( ~a & b ) |
             ( a & ~b );

endmodule

// VERILOG-EVAL: errant inclusion of module definition
