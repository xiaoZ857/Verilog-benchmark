
module TopModule (
  input wire a,
  input wire b,
  output reg out
);

assign out = ~(a | b);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
