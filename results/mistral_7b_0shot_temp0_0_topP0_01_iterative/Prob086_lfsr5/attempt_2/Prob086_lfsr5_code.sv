
module TopModule (
  input clk,
  input reset,
  output reg [4:0] q
);
reg [4:0] lfsr = 5'b10101; // Initial value of the LFSR

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
