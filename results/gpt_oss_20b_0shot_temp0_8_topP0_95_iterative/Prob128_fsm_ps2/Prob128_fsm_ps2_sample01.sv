
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  // State encoding
  // 2'b00 : searching for start byte (in[3] == 1)
  // 2'b01 : first byte received
  // 2'b10 : second byte received
  // 2'b11 : third byte

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
