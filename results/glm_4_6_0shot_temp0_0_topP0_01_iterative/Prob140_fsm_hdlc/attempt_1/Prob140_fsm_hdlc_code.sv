
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
  // State encoding for Moore FSM
  parameter S0 = 3'd0;  // Reset state / previous input was 0
  parameter S1 = 3'd1;  // Saw 01
  parameter S2 = 3'd2;  // Saw 011
  parameter S3 = 3'd3;  // Saw 0111
  parameter S4 = 3'd4;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
