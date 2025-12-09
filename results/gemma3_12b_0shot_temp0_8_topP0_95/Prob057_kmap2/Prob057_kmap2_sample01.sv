
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out
);

  assign out = (!a & !b & !c & d) | (!a & b & d) | (a & !b & c & d) | (a & b & c);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
