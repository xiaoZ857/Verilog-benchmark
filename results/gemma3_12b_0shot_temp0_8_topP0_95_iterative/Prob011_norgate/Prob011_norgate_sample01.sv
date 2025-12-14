
module TopModule (
  input a,
  input b,
  output out
);

  assign out = ~(a | b);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
