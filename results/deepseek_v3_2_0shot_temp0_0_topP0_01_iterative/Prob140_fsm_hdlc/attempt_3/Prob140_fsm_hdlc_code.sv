
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
  // State encoding: 4 bits for 10 states
  localparam S0 = 4'd0;  // Initial state, or after seeing 0
  localparam S1 = 4'd1;  // 1
  localparam S2 = 4'd2;  // 11
  localparam S3 = 4'd3;  // 111
  localparam S4 = 4'd4;  // 1111
  localparam S5 = 4'd5;  // 11111 (5 ones)
  localparam S6 = 4'd6;  // Saw 5 ones, then 0 (discard condition)
  localparam S7 = 4'd7;  // Saw 6 ones, then 0 (flag condition)
  localparam S8 = 4'd8;  // 1111111 (7 ones - error)
  localparam S9 = 4'd9;  // 8+ ones (stay in error)

  reg [3:0] state, next_state;
  
  // Moore outputs: depend only on current state
  // These are asserted one cycle AFTER the pattern completes
  assign disc = (state == S6);
  assign flag = (state == S7);
  assign err = (state == S8 || state == S9);

  always @(posedge clk) begin
    if (reset) begin
      state <= S0;
    end else begin
      state <= next_state;
    end
  end

  always @(*) begin
    case (state)
      S0: next_state = in ? S1 : S0;  // 0->S0, 1->S1
      S1: next_state = in ? S2 : S0;  // 1->S2, 0->S0
      S2: next_state = in ? S3 : S0;  // 1->S3, 0->S0
      S3: next_state = in ? S4 : S0;  // 1->S4, 0->S0
      S4: next_state = in ? S5 : S0;  // 1->S5, 0->S0
      S5: next_state = in ? S8 : S6;  // 5 ones: 1->error(S8), 0->discard(S6)
      S6: next_state = in ? S1 : S0;  // After discard: 1->S1, 0->S0
      S7: next_state = in ? S1 : S0;  // After flag: 1->S1, 0->S0
      S8: next_state = in ? S9 : S0;  // 7 ones: 1->S9, 0->S0
      S9: next_state = in ? S9 : S0;  // 8+ ones: stay in error until 0
      default: next_state = S0;
    endcase
  end

// VERILOG-EVAL: endmodule not found
