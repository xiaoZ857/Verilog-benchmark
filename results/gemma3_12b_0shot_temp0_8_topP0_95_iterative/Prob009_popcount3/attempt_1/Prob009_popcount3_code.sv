
module TopModule (
  input [2:0] in,
  output [1:0] out
);

  assign out = in[2] + in[1] + in[0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition
