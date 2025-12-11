
module TopModule (
  input [4:1] x,
  output logic f
);
assign f = (x[3] & x[2]) | ((~x[3] & ~x[2]) | (~x[3] & x[2] & x[4])) | ((x[3] & x[2] & x[4]) | (~x[3] & x[2] & x[4]));

// VERILOG-EVAL: endmodule not found
