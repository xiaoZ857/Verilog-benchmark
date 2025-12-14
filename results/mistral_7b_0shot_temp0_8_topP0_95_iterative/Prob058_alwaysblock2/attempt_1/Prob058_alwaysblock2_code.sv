
module TopModule (
  input clk,
  input a,
  input b,
  output out_assign
);

assign out_assign = a ^ b;

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
