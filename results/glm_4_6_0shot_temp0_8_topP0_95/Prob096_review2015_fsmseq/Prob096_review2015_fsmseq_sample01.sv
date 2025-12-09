
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
  // State encoding
  reg [2:0] current_state, next_state;
  
  parameter IDLE = 3'd0;    // No match yet
  parameter S1 = 3'd1;      // Have received "1"
  parameter S2 = 3'd2;      // Have received "11"
  parameter S3 = 3'd3;      // Have received "110"
  parameter FOUND = 3'd4;   // Have received "1101"
  
  // State register
  always @(posedge

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
