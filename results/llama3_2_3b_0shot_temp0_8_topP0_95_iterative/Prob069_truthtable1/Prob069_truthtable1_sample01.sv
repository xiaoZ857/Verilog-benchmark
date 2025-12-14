
// Implement the Verilog module based on the following description.
module TopModule (
  input x3,
  input x2,
  input x1,
  output f
);

assign f = (x1 & (~x3 | ~x2)) | ((~x1) & (x3 | x2));

endmodule

// VERILOG-EVAL: errant inclusion of module definition
