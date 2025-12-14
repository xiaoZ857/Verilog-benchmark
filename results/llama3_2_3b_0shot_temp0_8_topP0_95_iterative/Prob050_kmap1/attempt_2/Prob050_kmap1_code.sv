
module TopModule (
  input a,
  input b,
  input c,
  output out
);

assign out = (a & b) | ((~a & ~b) & c) | (~(a & !b)) | (!a & b);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
