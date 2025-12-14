
module TopModule (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);

  // Initialize outputs to default values (i.e., all zeros)
  assign out_or_bitwise = 3'b000;
  assign out_or_logical = 3'b000;
  assign out_not[2:1] = b[2:1];  // bits [5:4]
  assign out_not[0:0] = ~a[0:0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
