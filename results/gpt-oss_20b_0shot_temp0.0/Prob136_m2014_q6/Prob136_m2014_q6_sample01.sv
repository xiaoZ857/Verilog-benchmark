

module TopModule (
  input clk,
  input reset,
  input w,
  output z
);

  // State encoding
  localparam [2:0] STATE_A = 3'b000,
                   STATE_B = 3'b001,
                   STATE_C = 3'b010,
                   STATE_D = 3'b011,
                   STATE_E = 3'b100,
                   STATE_F = 3'b101;

  reg [2:0] state, next_state;

  // State register
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= STATE_A;
    else
      state <= next_state;
  end

  // Next state logic
  always @(*) begin
    case (state)
      STATE_A: next_state = (w == 1'b0) ? STATE_B : STATE_A;
      STATE_B: next_state = (w == 1'b0) ? STATE_C :

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
