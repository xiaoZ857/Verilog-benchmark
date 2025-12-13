
module TopModule (
  input [4:1] x,
  output logic f
);

assign f = ~x[3] & x[2] | x[3] & ~x[2] & x[1];

// Alternative implementation using if-else statements
// assign f = (x[3] && x[2] && !x[1]) || (!x[3] && !x[2]);

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
