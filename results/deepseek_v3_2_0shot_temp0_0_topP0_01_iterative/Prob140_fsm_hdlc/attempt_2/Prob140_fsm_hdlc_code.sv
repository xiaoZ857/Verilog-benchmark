
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
  // State encoding: 4 bits for 10 states
  localparam S0 = 4'd0;
  localparam S1 = 4'd1;
  localparam S2 = 4'd2;
  localparam S3 = 4'd3;
  localparam S4 = 4'd4;
  localparam S5 = 4'd5;
  localparam S6 = 4'd6;
  localparam S7 = 4'd7;
  localparam S8 = 4'd8;
  localparam S9 = 4'd9;

  reg [3:0] state, next_state;
  
  // Moore outputs: depend only on current state
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
      S0: next_state = in ? S1 : S0;
      S1: next_state = in ? S2 : S0;
      S2: next_state = in ? S3 : S0;
      S3: next_state = in ? S4 : S0;
      S4: next_state = in ? S5 : S0;
      S5: next_state = in ? S6 : S0;
      S6: next_state = in ? S8 : S7;  // After 5 ones and zero, if next is 1 -> error path
      S7: next_state = in ? S1 : S0;  // Flag state (01111110)
      S8: next_state = in ? S9 : S0;  // 7 ones
      S9: next_state = in ? S9 : S0;  // 8+ ones (stay in error until zero)
      default: next_state = S0;
    endcase
  end

endmodule
