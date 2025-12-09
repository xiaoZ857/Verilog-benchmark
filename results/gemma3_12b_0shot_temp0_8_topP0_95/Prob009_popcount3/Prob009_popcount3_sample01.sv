
module TopModule (
  input [2:0] in,
  output [1:0] out
);

  wire c0, c1, c2;

  assign c0 = in[0];
  assign c1 = c0 + in[1];
  assign c2 = c1 + in[2];

  assign out[0] = c2;
  assign out[1] = c1;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
