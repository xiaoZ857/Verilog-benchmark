
module TopModule (
  input [2:0] in,
  output [1:0] out
);

  assign out = in | (in >> 1) | (in >> 2);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
