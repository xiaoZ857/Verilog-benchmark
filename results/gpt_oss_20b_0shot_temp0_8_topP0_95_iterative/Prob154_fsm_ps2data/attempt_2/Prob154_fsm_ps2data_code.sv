
module TopModule (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
// FSM to detect 3‑byte messages whose first byte has in[3]==1
// and output the 24‑bit message on the cycle following the last byte.

  // State encoding
  localparam [2:0] IDLE  = 3'd0,
                   RCV1  = 

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
