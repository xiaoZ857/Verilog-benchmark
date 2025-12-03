

module TopModule (
  input clk,
  input in,
  input reset,
  output done
);

  // State encoding
  localparam IDLE      = 3'd0,
             START     = 3'd1,
             DATA      = 3'd2,
             STOP      = 3'd3,
             WAIT_STOP = 3'd4;

  reg [2:0] state, next_state;
  reg [2:0] bit_cnt;          // Counts data bits (0..7)
  reg done_reg

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
