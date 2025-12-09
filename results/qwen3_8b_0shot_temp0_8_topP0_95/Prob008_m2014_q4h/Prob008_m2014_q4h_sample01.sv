
module TopModule (
  input in,
  output out
);
  // Continuous assignment for combinational behavior
  assign out = in;
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
