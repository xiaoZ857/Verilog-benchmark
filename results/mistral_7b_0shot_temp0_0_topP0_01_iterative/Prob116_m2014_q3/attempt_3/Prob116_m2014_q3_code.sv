
module TopModule (
  input [4:1] x,
  output logic f
);

assign f = x[1] ^ x[3] ^ x[4];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
