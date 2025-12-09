
module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
We can implement this state machine using a parameterized state encoding and a synchronous reset. The state transitions and output z are defined per the description.

  parameter A = 3'b000;
  parameter B = 3'b001;
  parameter C = 3'b010;
  parameter D = 3'b011;
  parameter E = 3'b100;
  parameter F = 3'b101;

  reg [2:0] state, next_state;

  always @(posedge clk) begin
    if (reset)
      state <= A;
    else
      state <= next_state;
  end

  always @(*) begin
    case (state)
      A: next_state = (w == 1'b0) ? B : A;
      B: next_state = (w == 1'b0) ? C : D;
      C: next_state = (w == 1'b0) ? E : D;
      D: next_state = (w == 1'b0) ? F : A;
      E: next_state = (w == 1'b0) ? E : D;
      F: next_state = (w == 1'b0) ? C : D;
      default: next_state = A;
    endcase
  end

  assign z = (state == E || state == F) ? 1'b1 : 1'b0;
endmodule

// VERILOG-EVAL: abnormal backticks count
