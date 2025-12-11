
module TopModule (
  input [4:1] x,
  output logic f
);
assign f = (x[3] & x[4]) ^ ((~d) & x[2]) ^ (((~d)^d) & (~x[1])) ^ (((~x[1])&x[0]) | d);

// VERILOG-EVAL: endmodule not found
